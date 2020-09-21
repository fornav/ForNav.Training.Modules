# Setup
<dl>
  <dt><b>Level</b></dt>
  <dd>Basic</dd>
  <dt><b>Duration</b></dt>
  <dd>10 min</dd>
  <dt><b>Instructor participation</b></dt>
  <dd>Lead reflection</dd>
  <dt><b>Training approach</b></dt>
  <dd>Self Study</dd>
  <dt><b>Prerequisites</b></dt>
  <dd>All students have access to a Business Central instance (On Premise or SaaS) with the Cronus Database with a valid license. <br> All students have the ForNAV designer installed in the same environment.</dd>
  <dt><b>Training materials</b></dt>
  <dd>ForNAV.Guide Setup</dd>
  <dt><b>Objective</b></dt>
  <dd>After this module students have set up their ForNAV designer</dd>
</dl>

## Preparation
Duration: -

Download and install the ForNAV designer from the ForNAV website.
This is a pretraining exercise. Email instructions to participants before training.

### Email

Hello, thank you for joining the ForNAV training. To make sure we can start smoothly please prepare these things.
*	Download and install the ForNAV designer
*	Create a personal Sandbox/On Premise/Docker installation of Business Central 15/16. This needs a license that has the ForNAV granule added to it
*	Setup the ForNAV designer
*	Download and install the ForNAV Customizable Report Pack
*	If you have not done so already please install Visual Studio Code

Detailed instructions on how to do this are here: [SaaS](https://fornav.github.io/ForNav.Guide/#/ForNAVForBCSaaS/) or [On Premise](https://fornav.github.io/ForNav.Guide/#/ForNAVForBCOnPrem/)

If you have any questions on this setup or about the training in general please let me know.


### Video script
Hi and welcome to this Reports ForNAV training. We will start the training with the installation and setup of Reports ForNAV. The installation and Setup of ForNAV comes in two types, Cloud and On Premise. Please use the setup that is suitable for your installation type. Finally we will discuss the setup of the Customizable Report Pack. This is the same for both installation types.

**ForNAV Designer**

When we want to edit and create ForNAV reports we need to install the ForNAV Designer. You can download the latest version from the ForNAV website.

DEMO

*Install the ForNAV Designer.*

**Cloud**

The installation of ForNAV cloud starts with the installation of the Customizable Report Pack in your Business Central Tenant. This will install everything you need to run, edit, and create ForNAV reports.

DEMO

*Using a new sandbox Install the Customizable Report Pack from the Marketplace. Show which extensions are installed.*

The next step is to connect the ForNAV Designer to the Business Central tenant so it can read table and field information, load and save reports, and manage extensions.

DEMO

*Set up the ForNAV Designer to connect to Business Central Cloud.*

Once we have done this we are ready to work with ForNAV.

**On Premise**

The installation of ForNAV On Premise starts with the installation of the ForNAV Service Add In on your Business Central Service tiers. This will install the dll that ForNAV reports needs to render the layouts.

DEMO

*Install the ForNAV Designer Service Add In.*

The next step is to connect the ForNAV Designer to the Business Central service tier so it can read table and field information, load and save reports, and manage extensions. For this we need to ensure that the SOAP, OData, API, and developer ports are open.

DEMO

*Set up the ForNAV Designer to connect to Business Central On Prem. Show which extensions are installed on the server.*

Once we have set up the ForNAV Designer correctly we can install the ForNAV Customizable Report Pack. This is not mandatory but it is highly recommended.

DEMO

*Download and install the Customizable Report Pack extension and upload it to the server using the Designer. Show which extensions are installed.*

Once we have done this we are ready to work with ForNAV.


**Setup of the ForNAV Customizable Report Pack**

After installing the ForNAV Customizable Report Pack you can set it up so the ForNAV reports get added to your report selection, and add your logo, payment note, etc.

DEMO

*Wizard, ForNAV Setup, ForNAV Reports, My Reports.*

> https://www.fornav.com/download/

## Execution
Duration: -

[filename](../../Exercises/Setup.Exercise.md ':include')

## Reflection
Duration: 10 min

In the first meeting ask everyone if they managed to setup ForNAV correctly. Determine what went right and what did not.

### Questions (* marks the correct answer)
Why do you need to set up the connection in the ForNAV Designer?
* *To get the table and field information from Business Central and to be able to load and save extensions and layouts directly to Business Central
* To spy on your clients
* To load data directly from Business Central into the report layouts

Which ports need to be open in your On Premise server?
* *SOAP, ODATA, API, and Developer
* Nothing
* Developer, Client Services, SOAP

What is the correct installation order for ForNAV On Premise?
* *ForNAV Designer, ForNAV dll on the service tier, ForNAV Customizable Report Pack
* No specific order of installation
* ForNAV Customizable Report Pack, ForNAV Designer, ForNAV dll on the service tier

What is the correct installation order for ForNAV SaaS?
* *No specific order of installation
* ForNAV Designer, ForNAV dll on the service tier, ForNAV Customizable Report Pack
* ForNAV Customizable Report Pack, ForNAV Designer, ForNAV dll on the service tier
<!-- Add questions -->
