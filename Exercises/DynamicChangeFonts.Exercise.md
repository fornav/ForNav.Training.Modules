### Dynamically change fonts and colors Exercise

* Make the Header.DueDate text white on a blue background when the due date is earlier than today
* Create a new Body section for the line DataItem. Add a text control and set Line.Description as the Source Expression
* Only display this new section when the Line.Type is blank (comment line)
* Only display the existing section when the Line.Type is not blank
* Change the font of the Header.FieldGroups.Bill_toAddress bold and underlined when the address is not in your own country

Use the ForNAV Guide for [SaaS](https://renebrummel.github.io/ForNAVGuide/#/ForNAVForBCSaaS/EditYourFirstReport) or [On Premise](https://renebrummel.github.io/ForNAVGuide/#/ForNAVForBCOnPrem/EditYourFirstReport)


> [Format string cheatsheet](http://www.cheat-sheets.org/saved-copy/msnet-formatting-strings.pdf)

> [ForNAV Knowledge base](https://www.fornav.com/knowledge-base/advanced-formatting-with-fornav/)

### Demo scripts

Change colors

```javascript
if (Header.Amount > 5000) {
  CurrControl.ForeColor = 'blue';
  CurrControl.BackColor = 'yellow';
}
```
Change font

```javascript
switch(Line.Type) {
  case Line.FieldOptions.Type.G_LAccount:
    CurrControl.Font.Bold = true;
    break;
  case Line.FieldOptions.Type.Item:
    CurrControl.Font.Name = 'Comic Sans MS';
    break;
  default:
    CurrControl.Font.Size = 20;
}
```

Change Show Output

```javascript
Line.Type != Line.FieldOptions.Type.G_LAccount
```