### Create new reports Exercise

1. Create a new report based on the List Template
1. Save the new report as a new object on the server
1. Add a table to the body part with the fields No. Name, Address, and Balance (LCY);
1. Space the columns;
1. Add the background color Gainesboro to the odd rows;
1. Add a table with the captions for the No., Name, Address, and Balance (LCY) fields and add this to the Header part;
1. Space these columns the same as the body table;
1. Add all borders to the header table, make text bold and text size 8;
1. Add the Address Fieldgroup and add it to the address column in the body. Demo how ForNAV creates Fieldgroups; 
1. Set the Can Grow property on the Address field to true;
1. Set the Text Alignment property of the Address field to Top Left;
1. Set the Can Grow properties of the body table and Body1 section to true
1. Add a Payment Terms Description column between the Address and the Balance (LCY).
1. Add a page extension for this report.
<!-- 1. Sort Customers with the highest balance first, go to the properties of the list, go to Data Item Table View. Sort Descending on the field Balance (LCY); -->
<!-- 1. Only display the first ten records. Set Max Iteration to 10. -->

**Advanced Exercise**

Copy the report you just made and change the List DataItem table to Vendor. Call this report Vendor Top 10, and save it as a new object.

Use the ForNAV Guide for [SaaS]() or [On Premise]()


<!-- ToDO -> edit links -->

<!-- ### Sample scripts

**Get the ForNAV Setup table**
```javascript
ForNAVSetup.Get();
ForNAVSetup.CalcFields('Logo');
``` -->