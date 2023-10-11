---
layout: post
title:  "Base 64 Encoding and Decoding with DB2"
date:   2023-10-05
---

## Base64 encoding and decoding with DB2

Base64 encoding is a method for converting binary data into ASCII text. It's designed to prevent communication errors when transferring binary information.

The IBM i operating system provides two DB2 services that allow you to BASE64 encode and decode.

In this post we will discuss how to use these DB2 services, and why CCSID is an important consideration.  The examples given will utilize embedded SQL in an SQLRPGLE program.

### The IBM i DB2 services for Base64 encoding and decoding

[BASE64_ENCODE](https://www.ibm.com/docs/en/i/7.5?topic=functions-base64-encode) - returns the Base64 encoded version of a binary value.

[BASE64_DECODE](https://www.ibm.com/docs/en/i/7.5?topic=functions-base64-decode) - returns a character string that has been Base64 decoded

### Trying it out

First lets encode a string 'Encode This' in base64 using a simple SQLRPGLE program.

```
**free
Dcl-S PlainText VARCHAR(100) INZ('MyText');
Dcl-S EncodedText VARCHAR(100);
Dcl-S Message VARCHAR(100); 

Exec SQL Values QSYS2.BASE64_ENCODE(:PlainText) Into :EncodedText;
Message = 'EncodedText = ' + %trim(EncodedText);
snd-msg *INFO Message %TARGET(*SELF);
return;
```
Resulting joblog message:

>    EncodedText = 1Kjjhaej

Now, lets check that against a base64 encoder on the web: [https://www.base64encode.org/](https://www.base64encode.org/)

> ![bas64encode.org screen grab](/assets/images/base64-1.png)

The encoded value from our RPG program doesn't match the encoded value from www.base64encode.org.  The reason they don't match, is because of CCSID.  CCSID, or Coded Character Set Identitifier, is what uniquely identifies the specific encoding of a code page.

If you read the documentation for base64_encode, it gives examples of base64 encodeing for both EBCDIC (code page 37) and UTF-8 (code page 1208) CCSID.  ON IBM i, ebcdic is the default codepage. The specific code page can vary by region.  The code page for your machine is stored in a system value called QCCSID.  When your IBM i was delivered, it came with value 65535 - which isn't a real code page.  65535 basically means all character data tagging support support is turned off.  IBM recommends this value be changed.  In North America, the standard ebcdic code page for IBM i is 37.  For more information, read up on QCCSID [here](https://www.ibm.com/docs/en/i/7.5?topic=values-coded-character-set-identifier-qccsid-system-value).

With that understanding, if you want to base64 encode / decode like the rest of the world, and you probably do, you need to make some adjustments to your code:

```
**free
Dcl-S PlainText VARCHAR(100) INZ('MyText') CCSID(1208);
Dcl-S EncodedText VARCHAR(100);
Dcl-S Message VARCHAR(100); 

Exec SQL 
Values QSYS2.BASE64_ENCODE(PlainText) Into :EncodedText;
Message = 'EncodedText = ' + %trim(EncodedText);
snd-msg *INFO Message %TARGET(*SELF);
return;
```

Above, the only modification needed was to add the CCSID keyword to the definition for **PlainText**.  I used the specific value of `1208`, but could also have used `*UTF8`.  IBM's documentation suggests another method, which is to CAST the CCSID inline:

```
VALUES QSYS2.BASE64_ENCODE (CAST(EncodedText AS VARCHAR(10) CCSID 1208)) Into :EncodedText;
```

### And Now to Decode

Lets add a few more lines to our example that decode the now encoded message.

```
**free
Dcl-S PlainText VARCHAR(100) INZ('MyText') CCSID(1208);
Dcl-S EncodedText VARCHAR(100);
Dcl-S DecodedTextVarBinary sqltype(VARBINARY:100); 
Dcl-S TranslatedTextVarChar VARCHAR(100) CCSID(1208); 

Exec SQL 
Values QSYS2.BASE64_ENCODE(:PlainText) Into :EncodedText;
Message = 'EncodedText = ' + %trim(EncodedText);
snd-msg *INFO Message %TARGET(*SELF);

Exec SQL
Values QSYS2.BASE64_DECODE(:EncodedText) Into :DecodedTextVarBinary;

TranslatedTextVarChar = DecodedTextVarBinary;







return;


```


For example, If I take the text `Encode This` and drop it into any of the base64 encode/decode websites, it will come up with an encoded value of `RW5jb2RlIFRoaXM=`

