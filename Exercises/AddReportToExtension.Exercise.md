### Add reports to an extension Exercise

* Create a new empty extension
* Add the dependencies to the ForNAV Core and ForNAV Report Pack
* Create a new Sales Invoice report based on the Header Line template in the ForNAV Designer and save it as an AL object in your extension
* Publish your extension
* Change something in your report, save it and publish your extension form VS Code

Advanced exercise
* Download the Customer List report extension you created earlier and add that report to your new extension

Use the ForNAV Guide for [SaaS]() or [On Premise]()

[Demo extension with examples](https://github.com/renebrummel/ForNAV.TrainingModules/tree/master/Modules/20%20Add%20Reports%20To%20An%20Extension/AddReportsToExtensionDemo)
<!-- ToDO -> edit links -->

<!-- ### Saving reports to an extension

I have changed the logic in the designer so that if the target is internal or onprem then it will always set the compatibility to on-prem.

If the target is cloud or extension, it will look at the launch.json configurations. -->


### Add the assembly probing paths

In order to use dll files in your extension you need to tell Visual Studio Code where to find the assemblyProbingPaths. To do this you need to add these lines to the settings.json (in VS COde type Ctrl + Shift + P > Open Settings (JSON)).

```json
"al.assemblyProbingPaths": [
        "./.netpackages",
        "C:/Program Files/Microsoft Dynamics 365 Business Central/130/Service/Add-ins",
        "C:/Program Files/Reports ForNAV/Add-ins/ReportsForNAV"
]
```

### Enable the use of dlls in your extension

In order to use dlls in your extension the target property in the app.json needs to be set to On Premise


```json
  "target": "On Premise"
```

> This property can be different depending on the Business Central version you use.

### The ForNAV dependencies

You don't need to add any dependencies to your extension in order to create ForNAV reports for an On Premise extension. For ForNAV in a SaaS environment you just need the ForNAV Core extension. In order to copy custom versions of the report pack reports to your extension you need to add a dependency on the ForNAV report pack. In order to add them go to your app.json and add these dependencies.

```json
  "dependencies": [
    // The standard Business Central dependencies and any dependencies you already have will be here
    {
      "id": "6f0293d3-86fc-4ff8-9632-54a580be6546",
      "name": "ForNAV Core",
      "publisher": "ForNAV",
      "version": "5.0.0.0"
    },
    {
      "id": "83326d6d-11f8-49fd-981a-6f266a7c8d81",
      "name": "Customizable Report Pack",
      "publisher": "ForNAV",
      "version": "5.0.0.0"
    }
  ],
```