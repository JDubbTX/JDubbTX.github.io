---
layout: post
title:  "How to Build a Service Program"
date:   2023-10-16
---

## How to Build a Service Program

Service programs are a unique veature of ILE, allowing you to combine modules and procedures, written in one of the five ILE languages, into one set of procedures that are called by reference.  Unlike regular programs, service programs can have multiple entry points.  Service program generally do not exist on their own - usually they are bound to an ILE program.

## History of ILE

ILE, or the Integrated Language Environment, is a feature of the IBM i operating system since 1993.  The original AS400 operating system used the Original Program Model (OPM).  The extended program model (EPM) was later introduced for the C and Pascal programming languages.

## Service program building blocks

To build a service program, 3 things are needed
2) A Prototype
2) A module
3) Binder Language

From those 3 items we can create a service program that can be bound into other programs.

## The Prototype

A prototype defines the parameters that are necessary to call the exported procedures in the service program.  All prototype code will be saved in source files inside a folder named `QPTYPESRC` which is in the root of your project.  The filename of this prototype file is `PRINTER.RPGLEINC`.  It will define all prototypes for exported procedures in the PRINTER module.

Prototypes are externalized from the module so that they can be copied into the calling programs and procedures that need them.

```text
**FREE  
Dcl-Pr printThis ExtProc('*DclCase');
  inLabel char(21) const;
  inValue varchar(100) const;
End-Pr;
```

[Link to the Code](https://github.com/JDubbTX/IBMiExamples/tree/main/QPTYPESRC)

Our prototype is coded in fully-free RPGLE code, declaring one procedure named 'print_this', with two fields, a 21 character field named 'inLabel', and a varchar field of length 100 name 'inValue'.  Both fields use the keyword 'const' because they are not meant to be modified by the called procedure. 

## The Module

First we will create a simple module with a single entry point, or exported procedure that has one purpose - printing output to a spool file using the data that is passed in via 2 parameters:

```text
**free
ctl-opt NoMain option(*srcstmt) ReqPrExp(*require);
/copy ./qptypesrc/printer.rpgleinc
// Procedure for Printing to a spool file
dcl-proc printThis export;
  dcl-pi *n;
    inLabel char(21) const;
    inValue varchar(100) const;
  end-pi;

  Dcl-f QPRINT printer(132) static;
  dcl-ds line len(132) inz qualified;
    Label    char(21);
    *n       char(1);
    Val      char(100);
  end-ds;

  line.Label = inLabel;
  line.Val = inValue;
  write QPRINT line;

  return;
  
end-proc;
```

### Explaination of Module code

```text
**free
ctl-opt NoMain option(*srcstmt) ReqPrExp(*require);
/copy ./qptypesrc/printer.rpgleinc
```

All RPGLE examples in this blog will be in fully free-form RPGLE.  By putting `**FREE` on line 1 of our source file, the rpgle compiler allows us to start our code in column 1, instead of column 7.

We then use a couple of control specifications:
  1) `NoMain` indicates that there is no main procedure in this module
  2) `option(*srcstmt)` indicates that statement numbers for the listing are generated from the source ID and line sequence numbers.
  3) `ReqPrExp(*require)` means that a prototype definition is required for all exported procedures.  While this is keyword is optional, by including it we ensure that we don't forget to add a prototype definition to our prototype file - the module will not compile unless we do.

Finally, we use `/copy` with a relative path to the prototype file in order to make prototyped procedures and field definitions available to this module.

```text
dcl-proc printThis export;
  dcl-pi *n;
    inLabel char(21) const;
    inValue varchar(100) const;
  end-pi;
```

The `dcl-proc` keyword declares the start of a procedure definition in our module.  We give it a name `printThis` and make it available to calling programs via the `export` keyword.  Without the `export` keyword, this procedure would only be callable from within the module.

Next a procedure interface 


### Building the Module

With our prototype and module, we can build our module with a CL create command, `CRTRPGMOD`.  The **Code for IBM i** extension makes it easy by selecting `actions` and then `Create RPGLE Module`

![Alt text](/assets/images/BuildPrinterModule1.gif)

More to come ....




