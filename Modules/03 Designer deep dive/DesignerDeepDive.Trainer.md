# Designer deep dive
<dl>
  <dt><b>Level</b></dt>
  <dd>Basic</dd>
  <dt><b>Duration</b></dt>
  <dd>75 min</dd>
  <dt><b>Instructor participation</b></dt>
  <dd>Web: Demonstrate the designer features<br>Classroom: Demonstrate the designer features</dd>
  <dt><b>Training approach</b></dt>
  <dd>Demo, exercise, reflect on exercise</dd>
  <dt><b>Prerequisites</b></dt>
  <dd>All students have access to a Business Central instance (On Premise or SaaS) with the Cronus Database with a valid license. <br> All students have the ForNAV designer installed in the same environment.</dd>
  <dt><b>Training materials</b></dt>
  <dd>ForNAV Guide</dd>
  <dt><b>Objective</b></dt>
  <dd>After this module students will be able to add all types of controls and control the properties of those controls.</dd>
</dl>

## Pre Training
Watch the video [ForNAV Basic Features](ToDo)

## Preparation
Duration: 30 min

Demo. For developers open a report from the ForNAV Designer. For No-Code open the Sales Template

### Video Script
Now we have edited our first report with the ForNAV Designer let's go have a more detailed look at the menus and options we have.

**ForNAV Controls (Tool Box)**
The first part of the ForNAV Designer we will look at is the Controls part. In here you will find all the controls you can place in your report.

We will run though the controls one by one so you have a feel for what they do.

* Label
* Text Box
* Picture Box
* Image
* Cross Section Line + Box
* Shape
* Bar Code
* Table

**Lint**

The next part of the ForNAV Designer we will discuss is the lint.
* Explain options in Open/New/Save/Extensions
* Mention Undo/Redo
* Fonts
* Alignment + layout -> Mostly self explanatory

**Design Pane**

The main working area of the ForNAV Designer is the Design pane. It represents a graphical representation of the report layout that allows you to design the report. It consists of these parts.
* DataItems
* Sections
* Controls

**Report Explorer**

A very useful menu in the ForNAV Designer is the Report Explorer. The Report Explorer is an expandable list that contains all DataItems, Sections, and Controls of the report.
* DataItems
* Sections
* Controls

**Property Grid**

We have already looked at the quick access properties of the controls. Every DataItem, Section, and Control of a ForNAV report has many more properties though. You can see them in the property grid.
* Can Grow
* Multiline
* Format String
* Auto Fit
* Styles

**Field List**

We have seen before how we can add controls by selecting the desired control, dragging it into the report, and setting the source expression. There is an easier way of doing this though, that is through the Fields List. The field list contains an expandable list of all the DataItems connected to your report and their fields. 
* CurrReport
* DynamicsNavDataSet
* DataItems
  * Fields
  * FieldCaptions
  * FieldLookups
  * FieldOptions
* Add tables from Field List
* Add Picture/Bar Code from Field List

## Execution
Duration: 30 min

[filename](../../Exercises/DesignerDeepDive.Exercise.md ':include')

## Reflection
Duration: 15 min

Go over each exercise and discuss what happened at every point.

### Questions
What is the most efficient way to add a field to a ForNAV report?
* Drag the field from the field list into the report
* Drag an empty text box from the controls and add a source expression
* Create a new column in the AL report and use it in the report

What are ways of adding a table to your report
* Drag a table control from the controls list, select multiple fields in the field list with the ctrl key added and drag them to a report
* Drag a table control from the controls list, right click the section and click add a table
* right click the section and click add a table

Where can you find a list of all the used controls in your ForNAV report
* The Report Explorer
* The Field list
* The Standard controls

How would you add an image from the database
* In a Picture control
* In an Image control
* In a Shape control

What is the easiest way to align multiple controls to the left?
* Using the Alignment control in the lint
* Using the control properties
* Carefully aligning them all by dragging them to the correct position