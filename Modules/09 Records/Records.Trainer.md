# Related records
<dl>
  <dt><b>Level</b></dt>
  <dd>Intermediate</dd>
  <dt><b>Duration</b></dt>
  <dd></dd>
  <dt><b>Instructor participation</b></dt>
  <dd>Web: Video<br>Classroom: Demo</dd>
  <dt><b>Training approach</b></dt>
  <dd>Demo, exercise, reflect on exercise</dd>
  <dt><b>Prerequisites</b></dt>
  <dd>All students have access to a Business Central instance (On Premise or SaaS) with the Cronus Database with a valid license. <br> All students have the ForNAV designer installed in the same environment.</dd>
  <dt><b>Training materials</b></dt>
  <dd>ForNAV Guide</dd>
  <dt><b>Objective</b></dt>
  <dd>After this module students can get data from related tables without writing code.</dd>
</dl>

## Pre Training
Watch the video [Get data from related Business Central tables without writing code](https://www.youtube.com/watch?v=rf9H4LW2qiE&list=PLtpjnuA-F0c_XQ-y7kGZKAWCXeop7F7Wa&index=8&t=0s)

## Preparation
Duration:

> Demonstrate using the Sales Template report

* Demo the records in the records collection
* Explain Record.Get() and CalcFields
* Add the Item table. Link to the Line.No
* Explain filters
* Create a new body section and add these fields with captions
  * Item.NetWeight
  * Item.FieldLookups.ItemCategoryDescription
  * Item.FieldLookups.BaseUnitofMeasureDescription
  * Add captions for these fields
* Set the ShowOutput for this new section to:

```javascript
Line.Type == Line.FieldOptions.Type.Item
```

## Execution
Duration:

[filename](../../Exercises/Records.Exercise.md ':include')

## Reflection
Duration:

Go over the exercise. Make sure there are no question and everyone managed to do the exercise.
Explain the problem with added Records and templates. Demo using the Sales Invoice
