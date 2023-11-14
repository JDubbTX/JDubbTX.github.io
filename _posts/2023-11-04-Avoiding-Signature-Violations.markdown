---
layout: post
title:  "Avoiding Signature Violations in RPGLE"
date:   2023-10-16
---
When working with RPGLE service programs on IBM i, you must be mindful of the signature of the service program you are working on, in order to avoid a run-time error called a **signature violation**.

A signature violation looks like this:

![Signature Violation Error](/assets/images/Signatures.png)

## What is a signature violation?

When you create a program that has service programs bound to it, the current signature of the service program is stored in the program's meta data.  At run time, when the program calls a procedure in a service program, the service program's signatures are checked to see if any match the signature in the program's metadata.  If they don't match, a signature violation occurs.

## Signature visibility
In order to know if you will have a signature violation, its necessary to view the signatures of both the service program, and the signatures for the service program that are stored in the program metadata.

### Viewing signatures of the Service program

In a 5250 terminal you can easily view the service program's signature with the `DSPSRVPGM` command.  The signature is stored in binary / hexadecimal format, so you can use F11 key to view in a human readable format.  Of course if the signature was generated using `CRTSRVPGM EXPORT(*ALL)`, the signature will be gibberish.  Hopefully the signature of the service program was specified in binder language.

![DSPSRVPGM Signatures](/assets/images/DSPSRVPGM_Signature.png)

Another way to view the signature is with SQL.  Before we can query the signature in a readable way, we need to run a couple of SQL statements.

First we need to set the current_schema special register to a library name that we have access to.  This should be the same library that you created your service program in.

```T-SQL
set current_schema = 'JWEIRICH1';
```
Next we need a User Defined FUnction (UDF) scaler function that will UNHEX the signature, making it readable.

```
CREATE OR REPLACE FUNCTION unhex(in VARCHAR(32000))
RETURNS VARCHAR(32000)
RETURN in;
```

Finally, we can run some queries that will display the signatures in a human readable format.

The following query makes use of the PROGRAM_INFO db2 service that will return information about the service program, including the signature list.

```
SELECT 
PROGRAM_LIBRARY
, PROGRAM_NAME
, PROGRAM_LIBRARY
, PROGRAM_TYPE
, OBJECT_TYPE
, TEXT_DESCRIPTION
, EXPORT_SIGNATURES
, UNHEX( CAST(EXPORT_SIGNATURES as VARCHAR(32000))) as EXPORT_SIGNATURE_UNHEXED
  FROM QSYS2.PROGRAM_INFO
 WHERE PROGRAM_LIBRARY = current_schema
 and PROGRAM_NAME = 'PRINTER';
```

### Viewing bound service program signatures in a program

We can use the same `unhex` UDF to view the bound service program signature that is stored in the metadata of the Program.  In this example, the program name is `BASE64TST`.

```
SELECT a.*
  , UNHEX(CAST(a.BOUND_SERVICE_PROGRAM_SIGNATURE as VARCHAR(32000))) as Signature
  FROM QSYS2.BOUND_SRVPGM_INFO a
  WHERE PROGRAM_LIBRARY = current_schema
  and program_name = 'BASE64TST'
  and bound_service_program_library != 'QSYS'
  ;
```

## Catching signature violations ahead of time

