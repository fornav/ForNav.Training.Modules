### JavaScript Exercise

* Do the exercises from [Dynamically change fonts and colors](/Exercises/DynamicChangeFonts.Exercise.md)
* Get the sales comment lines for an invoice header and display them on an automatically growing header section

Advanced option
* Get an array of Sales Invoice Line comments
* Display them underneath the VAT Amount Line

Use the ForNAV Guide for [SaaS]() or [On Premise]()

<!-- ToDO -> edit links -->

### Demo Scripts

**Get comment lines**

For maximum effect this should be placed in the OnPreReport trigger so it can be inherited by any reports that use it as a master template

```javascript
function GetComments(headerNo) {
  var comments;
  
  SalesCommentLine.SetFilter('DocumentType', SalesCommentLine.FieldOptions.DocumentType.PostedInvoice);
  SalesCommentLine.SetFilter('No', headerNo);
  if (SalesCommentLine.First()) {
    comments = SalesCommentLine.Comment;
  }
  
  while (SalesCommentLine.Next()) {
    comments += ' ' + SalesCommentLine.Comment;
  }
  return comments;
}
```
> The .Next() function cannot be used in Business Central cloud 

**Get comment lines as an array**

Add this to the Header OnAfterGetRecord
```javascript
var comments = [];

function GetComments(headerNo, lineNo) {
  var _comments = [];
  var _comment;
  
  SalesCommentLine.SetFilter('DocumentType', SalesCommentLine.FieldOptions.DocumentType.PostedInvoice);
  SalesCommentLine.SetFilter('No', headerNo);
  SalesCommentLine.SetFilter('LineNo', lineNo);

  if (SalesCommentLine.First()) {
    _comment = {date:SalesCommentLine.Date, lineNo:Line.LineNo, comment:SalesCommentLine.Comment};
    _comments.push(_comment);
  }
  
  while (SalesCommentLine.Next()) {
    _comment = {date:SalesCommentLine.Date, lineNo:Line.LineNo, comment:SalesCommentLine.Comment};
    _comments.push(_comment);
  }
  return _comments;
}

function ParseComments(_comments) {
  var _parsedComment, i;
  _parsedComment = '';

  for (i = 0; i < _comments.length; i++) {
    _parsedComment += _comments[i].lineNo + ' ' + _comments[i].date + ' ' + _comments[i].comment + '\n ';
  }
  return _parsedComment;
}
```
> The .Next() function cannot be used in Business Central cloud 

Add this to the Line.OnAfterGetRecord
```javascript
comments.push.apply(comments, GetComments(Line.DocumentNo, Line.LineNo));
```

Add a new DataItem, set the source table as Integer and set MaxIteration on 1. Add a Body section with a Text control and add this as the source expression

```javascript
ParseComments(comments);
```

**Get the bank account based on the currency**

Add the Bank Account table to the records and get the record based on the currency.
```javascript
switch(Header.CurrencyCode) {
  case Header.CurrencyCode = 'EUR':
    BankAccount.Get('EURBANKNO');
    break;
  case Header.CurrencyCode = 'USD':
    BankAccount.Get('USDBANKNO');
    break;
  default:
    BankAccount.Get('DEFAULTBANKNO');
}
```

Add the Bank Account table to the records and find the first bank account for that currency.
```javascript
BankAccount.SetRange('CurrencyCode', Header.CurrencyCode);
BankAccount.First();
```

**Convert decimals to US Format**

Converts any number to the US Format in 2 decimals
```javascript
Number.prototype.usFormat = function(){
  return this.toFixed(2).replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1,");
}
```

Converts without adding decimal places
```javascript
Number.prototype.usFormat = function(){
    return this.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1,");
}
```

Call this function from any number:
```javascript
Headers.Amount.usFormat();
```

### Business Central functions in JavaScript

|JavaScript                     |AL                             |
|-------------------------------|-------------------------------|
|Get();)                        |Get();                         |
|CalcFields(‘Picture’);         |CalcFields(Picture);           |
|SetAutoCalcFields(‘Balance’);  |SetAutoCalcFields(Balance);    |
|Init();                        |Init;                          |
|Next();                        |Next;                          |
|First();                       |FindFirst;                     |
|SetFilter(‘Name’, ‘Mark’);     |SetFilter(Name, ‘Mark’);       |
|SetRange(‘Name’, ‘Mark’);      |SetRange(Name, ‘Mark’);        |
|GetCaption()                   ||
|GetOptionValue(string ExternalFieldName)||
|GetFilter(string ExternalFieldName)||
|GetFilters()||
|<br>
|Case Sensitive                 |Not case sensitive             |
|Parentheses mandatory          |Parentheses somewhat mandatory |
|Fieldnames in single quotes	|Fieldnames not in quotes   	|
|Brackets {}                    |Begin...End;                   |

### JavaScript Order of execution
![JavaScript Order of execution](../_Media/ForNAV%20Order%20of%20execution.png)

### Useful links

Online Learning
* [Codecademy](https://www.codecademy.com/)
* [Knowledge Base Dynamic control of fonts](https://www.fornav.com/knowledge-base/dynamic-control-of-color-and-font-in-text-boxes/ )
* [Online JavaScript Editor](https://js.do/)
* [W3Schools JavaScript](https://www.w3schools.com/js/default.asp)

Videos
* [Learn JavaScript in one video](https://www.youtube.com/watch?v=fju9ii8YsGs)
* [Change fonts/color/show output with JavaScript](https://www.youtube.com/watch?v=T-GY6ObU82c&list=PLtpjnuA-F0c_XQ-y7kGZKAWCXeop7F7Wa&index=11)
* [Working with JavaScript in the ForNAV Designer](https://www.youtube.com/watch?v=4cwbxUq-tc8&t=0s&index=11&list=PLtpjnuA-F0c9bZf3emvhz86-S1uX0a0II)

