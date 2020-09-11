# Dynamically change fonts and colors 
<dl>
  <dt><b>Level</b></dt>
  <dd>Intermediate</dd>
  <dt><b>Duration</b></dt>
  <dd></dd>
  <dt><b>Instructor participation</b></dt>
  <dd>Web: Demo<br>Classroom: Demo</dd>
  <dt><b>Training approach</b></dt>
  <dd>Demo, exercise, reflect on exercise</dd>
  <dt><b>Prerequisites</b></dt>
  <dd>All students have access to a Business Central instance (On Premise or SaaS) with the Cronus Database with a valid license. <br> All students have the ForNAV designer installed in the same environment.</dd>
  <dt><b>Training materials</b></dt>
  <dd>ForNAV Guide<br>Demo code<br>Links to Format Strings</dd>
  <dt><b>Objective</b></dt>
  <dd>After this module students can change fonts, colors and show output based on conditions.</dd>
</dl>

## Pre Training
Watch the video [Change fonts/color/show output with JavaScript](https://www.youtube.com/watch?v=T-GY6ObU82c&list=PLtpjnuA-F0c_XQ-y7kGZKAWCXeop7F7Wa&index=3&t=0s)

## Preparation
Duration:

> Demonstrate using the Sales Template report

First step, change color
* Explain CurrControl.ForeColor and CurrControl.BackColor
* To demonstrate use this script in the amount OnPrint property:

```javascript
if (Header.Amount > 5000) {
  CurrControl.ForeColor = 'blue';
  CurrControl.BackColor = 'yellow';
}
```
Second step, change font
* Explain the CurrControl.Font options.
* To demonstrate use this script in the Line.Description field:

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

Third step, Show Output
* Explain the general behavior of the Show Output property
* Go to the ShowOutput of the Quantity control of the line. Enter this line of JavaScript:

```javascript
Line.Type != Line.FieldOptions.Type.G_LAccount
```
Fourth step, explain CurrControl.Format.
* Explain this can take any string to control the format. Use the Format String property of a field to demonstrate strings.

## Execution
Duration:

[filename](../../Exercises/DynamicChangeFonts.Exercise.md ':include')

## Reflection
Duration:

What would you use this for?
