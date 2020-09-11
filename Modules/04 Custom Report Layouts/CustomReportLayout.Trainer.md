# Custom Report Layouts
<dl>
  <dt><b>Level</b></dt>
  <dd>Basic</dd>
  <dt><b>Duration</b></dt>
  <dd>30 min</dd>
  <dt><b>Instructor participation</b></dt>
  <dd>Web: Video<br>Classroom: Demo</dd>
  <dt><b>Training approach</b></dt>
  <dd>Demo, exercise, reflect on exercise</dd>
  <dt><b>Prerequisites</b></dt>
  <dd>All students have access to a Business Central instance (On Premise or SaaS) with the Cronus Database with a valid license. <br> All students have the ForNAV designer installed in the same environment.</dd>
  <dt><b>Training materials</b></dt>
  <dd>ForNAV Guide</dd>
  <dt><b>Objective</b></dt>
  <dd>After this module students can Export ForNAV layouts and import them in a different environment.</dd>
</dl>

## Pre Training
Watch the video [Save, import, export, and activate custom Business Central layouts](https://www.youtube.com/watch?v=SyY8uXT6Y-o&list=PLtpjnuA-F0c_XQ-y7kGZKAWCXeop7F7Wa&index=5&t=0s)

## Preparation
Duration:

Demonstrate how ForNAV creates a custom report layout when reports are changed from the client. Demonstrate export and import. Demonstrate also how docx files seem empty.

Developers only: Demonstrate moving custom layouts to an extension.


### Video Script
When you want to make changes to reports that are in extensions that you have not created yourself you need to save these changes in a new custom layout. This is because you cannot change the built-in layouts of these reports.
Before we can export our ForNAV layout changes we first need to make some changes to export. From Report Pack version 5.3 it is now possible to easily create and edit multiple layouts for ForNAV reports.

DEMO

*Create 2 layouts for the ForNAV Customer List and 2 for the Vendor list.*

Once the layouts are created, we can export them all in one go. Using the export function from the Standard Reports list will download a fornavlayouts file than will contain all the custom ForNAV layouts in your database.

DEMO

*Export the layouts. Use 7zip to demonstrate the content of the file.*

Now we have an export file we can import the report layouts in a different database.

DEMO

*Import in a different database.*


## Execution
Duration:

[filename](../../Exercises/CustomReportLayout.Exercise.md ':include')

## Reflection
Duration:

### Questions (* marks the correct answer)
Why does ForNAV save the layout changes to a custom layout?
* *Because you cannot edit the source extensions that contain these reports
* Because ForNAV cannot edit extensions
* Because you cannot edit PDF files

Where are these Custom Report Layouts stored?
* *In the Custom Report Layout table of the Business Central tenant you are working on
* In the memory of the ForNAV designer
* On your local hard drive

How can you backup these Custom Report Layouts?
* *Export them to a folder on your pc, or backup the Business Central database
* Save them in the cloud
* Run the backup wizard

How can you move the Custom Report Layouts?
* *Export them to a local folder and import them in a different database
* Copy them in the cloud
* Restore the Business Central database