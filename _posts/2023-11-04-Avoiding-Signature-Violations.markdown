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

In a 5250 terminal you can easily view the service program's signature with the DSPSRVPGM command.  The signature is stored in binary / hexadecimal format, so you can use F11 key to view in a human readable format.



## Catching signature violations ahead of time

If a