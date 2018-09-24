﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm2.aspx.cs" Inherits="WebApplication6.WebForm2" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>CMLUCA</title>

    <link rel="stylesheet" href="http://serverapi.arcgisonline.com/jsapi/arcgis/3.5/js/dojo/dijit/themes/claro/claro.css"/>
        <link rel="stylesheet" href="http://serverapi.arcgisonline.com/jsapi/arcgis/3.5/js/esri/css/esri.css"/>
   <!-- <link rel="stylesheet" href="http://js.arcgis.com/3.9/js/dojo/dijit/themes/claro/claro.css"/>    
    <link rel="stylesheet" href="http://js.arcgis.com/3.9/js/esri/css/esri.css"/>-->
    
        <link rel="stylesheet" href="Content/PrintCSS.css" />
    <link href="Content/accordion.css" rel="stylesheet"/>
<style> 
     
      /*.esriBasemapGallerySelectedNode .esriBasemapGalleryThumbnail{
        border-color: #66FFFF !important;
      }*/
      
    </style> 
    
   <!--  <script type="text/javascript" src="/jsapi_vsdoc12_v35.js"></script>-->

    

    
     
    <%--  <script src="http://serverapi.arcgisonline.com/jsapi/arcgis/3.5"></script>--%>
    <script src="http://js.arcgis.com/3.5/"></script>
     <%--<script src="dojo1.7/dojo/dojo.js" data-dojo-config="async: true, parseOnLoad: true">--%>



</head>
  <body class="claro">
        <form id="Form1"  runat="server" style="height: 100%;">

            <script>
                dojo.require("esri.map");
                dojo.require("esri.tasks.locator");
                dojo.require("esri.layers.ArcGISDynamicMapServiceLayer");
                dojo.require("esri.layers.ArcGISTiledMapServiceLayer");
                dojo.require("esri.dijit.BasemapGallery");
                dojo.require("dijit.layout.BorderContainer");
                dojo.require("esri.tasks.identify");
                dojo.require("esri.arcgis.utils");
                dojo.require("dojo.parser");
                dojo.require("dojo.domReady!");
                dojo.require("dojo.dom");
               
                dojo.require("dojo._base.array");
                dojo.require("esri.tasks.query");
                dojo.require("esri.tasks.QueryTask");
                dojo.require("esri.geometry.Point");
                dojo.require("esri.symbols.SimpleFillSymbol");
                dojo.require("esri.symbols.SimpleLineSymbol");
                dojo.require("esri.graphic");
                dojo.require("esri.SpatialReference");
                dojo.require("esri.tasks.geometry");
                dojo.require("esri.tasks.BufferParameters");
                dojo.require("esri.tasks.GeometryService");




                //var app = {};
           
                //var map, locator, geom, geom2, QT, QTAir, zoomextent, QTBase, QTSpecial, QCounty, QSpecial, QAir, QBase, symbol, counter, identifyTask, msgInstallations, identifyParams, msgSpecialAir, circleSymb, msgTrainingRoutes;
                var map2, locator, selectedvalue,x,y, graphic, address2, geom, geom1000, clickpoint,  sender, geom4000, gsvc, geom2, DoBuffer, params, QT, zoomextent, QCounty, symbol, counter, identifyTask, BufferParameters, msgInstallations, identifyParams, msgSpecialAir, circleSymb, msgTrainingRoutes, qTask, check, qQuery;
           
                //  dojo.ready(
                function init() {
               
                
                    esriConfig.defaults.io.proxyUrl = "/arcgisserver/apis/javascript/proxy/proxy.ashx";
                    esriConfig.defaults.io.alwaysUseProxy = false;

                    //dojo.connect(map, "onload", mapready());
                

                    // dojo.connect(qTask, "oncomplete", CountyQuery2());
                
               
                    //gsvc = new esri.tasks.GeometryService("http://tasks.arcgisonline.com/ArcGIS/rest/services/Geometry/GeometryServer");

                    gsvc = new esri.tasks.GeometryService("http://services.gis.ca.gov/arcgis/rest/services/Utilities/Geometry/GeometryServer");
                


                    map2 = new esri.Map("map", {
                        basemap: "gray",
                        center: [-120.500, 37.455],
                        zoom:6,
                        logo: false
                    });

              
                    var Branches = new esri.layers.ArcGISDynamicMapServiceLayer("http://services.gis.ca.gov/ArcGIS/rest/services/IntelligenceMilitary/MilitaryInstallations/MapServer", { "opacity": 0.60 });
               
                    map2.addLayer(Branches);

                    var Paths = new esri.layers.ArcGISDynamicMapServiceLayer("http://services.gis.ca.gov/ArcGIS/rest/services/IntelligenceMilitary/MilitaryTrainingFlightRoutes/MapServer", { "opacity": 0.60 });
                
                    map2.addLayer(Paths);

                    var airspace = new esri.layers.ArcGISDynamicMapServiceLayer("http://services.gis.ca.gov/ArcGIS/rest/services/IntelligenceMilitary/MilitarySpecialUseAirspace/MapServer", { "opacity": 0.60 });
               
                    map2.addLayer(airspace);

                    var counties = new esri.layers.ArcGISDynamicMapServiceLayer("http://services.gis.ca.gov/ArcGIS/rest/services/Boundaries/CA_Counties/MapServer");
                    map2.addLayer(counties);

               


                    //dojo.connect("map", onload, mapready());
                    dojo.connect(map2, "onload", mapready());
                    
                    //var check = new String();
                   // check = "<%=_check%>";
                    

                

                    //dojo.connect(qTask, "oncomplete", CountyQuery2());



                    //qTask = new esri.tasks.QueryTask("http://services.gis.ca.gov/arcgis/rest/services/Boundaries/CA_Counties/MapServer/0");
                    //if (check == "true")
                    //{
                    //    qTask = new esri.tasks.QueryTask("http://services.gis.ca.gov/ArcGIS/rest/services/Government/CACounties10/MapServer/0");

                    //}

                    //if (check == "false")
                    //{
                        //qTask = new esri.tasks.QueryTask("http://services.gis.ca.gov/ArcGIS/rest/services/Government/CACounties10/MapServer/1");

                    //}
                    //qQuery = new esri.tasks.query();

                    //map.setExtent(extent);











             

                }
            
           

                //dojo.ready(init);

                function DoBuffer(){


                 
                    //if(address2 !== undefined){
                    //    alert("Creating report for location: " + address2);
                    //}
                    //else if (address2 == undefined){
                    //    alert("Creating report for point: " + x + ","+y);
                    //}
                   
                    //alert("buffering...");

                    alert("Creating report for point: " + x + ","+y);

                    SR =  new esri.SpatialReference({wkid:3857});


                    params = new esri.tasks.BufferParameters();
                    var Cpoint = new esri.geometry.Point();
                   
                    Cpoint.setX(x);
                    Cpoint.setY(y);
                    Cpoint.spatialReference= SR;

                        


                          



                            
                    params.geometries = [Cpoint];
                    //buffer in linear units such as meters, km, miles etc.
                    params.distances = [1000, 4000];
                    params.unit = esri.tasks.GeometryService.UNIT_FOOT;
                    params.outSpatialReference = map.spatialReference;

                    gsvc.buffer(params, showBuffer);
                }


                function showBuffer(geometries) {
                    var symbol = new esri.symbol.SimpleFillSymbol(
                      esri.symbol.SimpleFillSymbol.STYLE_SOLID,
                      new esri.symbol.SimpleLineSymbol(
                        esri.symbol.SimpleLineSymbol.STYLE_SOLID,
                        new dojo.Color([0, 0, 255, 0.65]), 2
                      ),
                      new dojo.Color([0, 0, 255, 0.35])
                    );


                    geom1000 = geometries[0];
                    geom4000 = geometries[1];

                    //alert("loading layers");

                    var graphic = new esri.Graphic(geom1000, symbol);
                    var graphic2 = new esri.Graphic(geom4000, symbol);

                  

                    map2.graphics.add(graphic);
                    map2.graphics.add(graphic2);

                    


                    var zoomextent2 = geom4000.getExtent().expand(1.5);
                
                    map2.setExtent(zoomextent2);
                    
               
                }


              

                

            

                function CallQuery() {

                   
                   

                    //var Xlarge = new Number();
                    //var Xsmall = new Number();
                    //var Ylarge = new Number();
                    //var Ysmall = new Number();
                    var county = new String();

                    county = "<%=_county%>";
                    //Xlarge = <%=_xlarge%>;
                    //Xsmall = <%=_xsmall%>;
                    //Ylarge = <%=_ylarge%>;
                    //Ysmall = <%=_ysmall%>;

                    //var character = '"';

               

                    //alert (county);

                    //county="Placer";

                    alert("Creating report for " + county);

                    // qTask = new esri.tasks.QueryTask("http://services.gis.ca.gov/arcgis/rest/services/Boundaries/CA_Counties/MapServer/0");

                    check = "<%=_check%>";
                    
                    
                    if (check == "true")
                        {
                            qTask = new esri.tasks.QueryTask("http://services.gis.ca.gov/ArcGIS/rest/services/Government/CACounties10/MapServer/0");

                        }

                        if (check == "false")
                        {
                            qTask = new esri.tasks.QueryTask("http://services.gis.ca.gov/arcgis/rest/services/Boundaries/CA_Counties/MapServer/0");

                        }
                    
                    
                    
                    
                    
                    qQuery = new esri.tasks.Query();
                    qQuery.returnGeometry = true;
                    qQuery.where = "POLYGON_NM = '" + county + "'";
                    //qQuery.where = "POLYGON_NM = 'Placer'";
              
                    //qTask.oncomplete(CountyQuery2());
              

                    qTask.execute(qQuery,showme);

              

                

                }

                function showme(results){
                    
                    var resultItems = [];
                    var resultCount = results.features.length;
                    var highlightSymbol2 = new esri.symbol.SimpleFillSymbol(esri.symbol.SimpleFillSymbol.STYLE_FORWARD_DIAGONAL).setColor(new dojo.Color([238, 28, 36]));

                    var geom = results.features[0].geometry;
                    var graphic = new esri.Graphic(geom, highlightSymbol2);

                
                       
               
               
                    //map.graphics.add(graphic);

                    counter= 1;

                    while(counter<=3){
                        map2.graphics.add(graphic);
                        counter=counter+1;
                    }
                }

                function mapready(){

                    //alert("ready");
                    //var Xlarge = new Number();
                    //var Xsmall = new Number();
                    //var Ylarge = new Number();
                    //var Ysmall = new Number();
                    var county = new String();
                    var action = new String();
                    var Q4000 = new String();
                    var s4000 = new String();
                    var r4000 = new String();
                    var b4000 = new String();


                    installations = "";
                    flightroute = "";
                    specialuse = "";
                    //x=undefined;
                    //y=undefined;
                        

                    county = "<%=_county%>";
                        Xlarge = <%=_xlarge%>;
                        Xsmall = <%=_xsmall%>;
                        Ylarge = <%=_ylarge%>;
                        Ysmall = <%=_ysmall%>;
                        action ="<%=_action%>";
                        specialuse ="<%=_specialuse%>";
                        installations ="<%=_installations%>";
                        flightroute ="<%=_flightroute%>";
                        x ="<%=_x%>";
                        y ="<%=_y%>";
                        address = "<%=_address%>";
                        address2=address;
                        Q4000 = "<%=_4000%>";                        
                        s4000 = "<%=_SU4000%>";
                        r4000 = "<%=_AS4000%>";
                        b4000 = "<%=_MB4000%>";

                      
               
                        dojo.doc.getElementById("txt2").style.visibility = "hidden";
                        dojo.doc.getElementById("txt3").style.visibility = "hidden";
                        dojo.doc.getElementById("txt4").style.visibility = "hidden";
        

                        var extent = new esri.geometry.Extent({
                            "xmin": Xsmall, "ymin": Ysmall, "xmax": Xlarge, "ymax": Ylarge,
                            "spatialReference": { "wkid": 102100 }
                        });

                        extent2 = extent.expand(2);

                        check = "<%=_check%>";



                        if ( specialuse == "undefined"){
                            dojo.doc.getElementById("special").style.visibility = "hidden";
                        }
                        if ( installations == "undefined"){
                            dojo.doc.getElementById("places").style.visibility = "hidden";
                        }
                        if ( flightroute == "undefined"){
                            dojo.doc.getElementById("route").style.visibility = "hidden";
                        }

                        if (x=="undefined"){
                            if (check=="false"){
                                document.getElementById("GeoName").innerHTML = county + " County: " + action;
                            }

                            if (check=="true"){
                                document.getElementById("GeoName").innerHTML = county + ": "+ action;
                            }
                        }

                
                        //if (x=="undefined" && check == "false"){
                        //    document.getElementById("GeoName").innerHTML = county + " County: " + action;
                        //}

                        //if (x=="undefined" && check == "true"){
                        //    document.getElementById("GeoName").innerHTML = county + action;
                        //}


                        else
                        {
                            document.getElementById("GeoName").innerHTML = x + ", " + y +": "+ action;
                            dojo.doc.getElementById("txt1").style.visibility = "hidden";
                            dojo.doc.getElementById("txt3").style.visibility = "hidden";
                            dojo.doc.getElementById("txt2").style.visibility = "visible";
                    
                        }

                        if (address!=="undefined"){
                            document.getElementById("GeoName").innerHTML = address+": "+ action;
                            dojo.doc.getElementById("txt1").style.visibility = "hidden";
                            dojo.doc.getElementById("txt3").style.visibility = "hidden";
                            dojo.doc.getElementById("txt2").style.visibility = "visible";
                        }


                        if (action=="No Action Required"){
                    
                            dojo.doc.getElementById("txt1").style.visibility = "hidden";
                            dojo.doc.getElementById("txt2").style.visibility = "hidden";
                            dojo.doc.getElementById("txt3").style.visibility = "visible";
                        }

                        //if (Q4000=="no"){
                    
                        //    dojo.doc.getElementById("txt1").style.visibility = "hidden";
                        //    dojo.doc.getElementById("txt2").style.visibility = "hidden";
                        //    dojo.doc.getElementById("txt3").style.visibility = "hidden";
                        //    dojo.doc.getElementById("txt4").style.visibility = "visible";
                        //}


                
                


                        installations = installations.fontsize(2).bold();
                        flightroute = flightroute.fontsize(2).bold();
                        specialuse = specialuse.fontsize(2).bold();

                        document.getElementById("places").innerHTML = installations;
                        document.getElementById("route").innerHTML = flightroute;                
                        document.getElementById("special").innerHTML = specialuse;

                        if (Q4000=="no"){
                    
                            dojo.doc.getElementById("txt1").style.visibility = "hidden";
                            dojo.doc.getElementById("txt2").style.visibility = "hidden";
                            dojo.doc.getElementById("txt3").style.visibility = "hidden";
                            dojo.doc.getElementById("txt4").style.visibility = "visible";

                           
                            dojo.doc.getElementById("places").style.visibility = "visible";
                            dojo.doc.getElementById("special").style.visibility = "visible";
                            dojo.doc.getElementById("route").style.visibility = "visible"; 

                            if ( s4000 == "undefined"){
                                dojo.doc.getElementById("special").style.visibility = "hidden";
                                
                            }
                            if ( b4000 == "undefined"){
                                dojo.doc.getElementById("places").style.visibility = "hidden";
                                
                            }
                            if ( r4000 == "undefined"){
                                dojo.doc.getElementById("route").style.visibility = "hidden";
                                
                            }


                            s4000 = s4000.fontsize(2).bold();
                            r4000 = r4000.fontsize(2).bold();
                            b4000 = b4000.fontsize(2).bold();

                            document.getElementById("places").innerHTML = b4000 ;
                            document.getElementById("route").innerHTML = r4000 ;                
                            document.getElementById("special").innerHTML = s4000 ;
                        }



                      
                    

                
             
                        map2.setExtent(extent2);



             
                        if ( county == "undefined"){

                            DoBuffer();

                           
                           
                    
                        }
                        else
                        {
                            CallQuery();
                        }



                       
               
               

                    }

                    //function CountyQuery(results) {


                    //    var resultItems = [];
                    //    var resultCount = results.features.length;
                    //    var highlightSymbol2 = new esri.symbol.SimpleFillSymbol(esri.symbol.SimpleFillSymbol.STYLE_FORWARD_DIAGONAL).setColor(new dojo.Color([238, 28, 36]));

                    //    var geom = results.features[0].geometry;
                    //    var graphic = new esri.Graphic(geom, highlightSymbol2);

                

               
              
               

                    //    map.graphics.add(graphic);


                
                    //}

                    dojo.ready(init);



                    //}


                    



                    

        </script>

               
           
            <div class="container"> 

                <div class="title" >CMLUCA Report</div>



                <div class="header" id="txt1">
                Thank you for using the CMLUCA system.<br />                  

California Government Code section 65352 requires Cities and Counties which are adopting or substantially amending a general plan to refer the proposed action to the branches of the United States Armed Forces when the proposed action is within 1,000 feet of a military installation, lies within special use airspace, or is beneath a low-level flight path, as defined in Section 21098 of the Public Resources Code.<br />

If you are receiving this report there are installations, special use airspace or low-level flight paths within your County, as depicted on the CMLUCA map. Your County should follow the protocol outlined in Gov. Code sections 65352, 65404, 65940, and 65944, as amended by SB 1462 (Khuel, 2004). Specifically, your County should contact the Military Points of Contact listed on the SB 1462 Point of Contact list. The list is available here: http://cmluca.projects.atlas.ca.gov/SB1462_POClistupdated4_2013.htm <br />

The list is also available on the Governor’s Office of Planning and Research (OPR) website: http://opr.ca.gov/s_military.php <br />

OPR has published a Community and Military Compatibility Planning Supplement to the General Plan Guidelines, which may assist you with your planning efforts. The Supplement is available here: http://opr.ca.gov/docs/Military_GPG_Supplement.pdf 

Please contact OPR at (916) 322-2318 or P.O. Box 3044, Sacramento, CA 95812-3044 if you have questions about your military notification requirements. Should you have questions regarding military operations within your area, contact any of the Military Point of Contact available at http://cmluca.projects.atlas.ca.gov/SB1462_POClistupdated4_2013.html. If you are unsure of the Military Point of Contact, please contact the Regional Coordination Team at (619) 532-4268 or mail your inquiry to 1220 Pacific Hwy, San Diego, CA 92132.

                    
                </div>

                 <div class="header" id="txt2">
               Your project location intersects with the above military layers. Please provide the above information to your local planning agency as part of your permit application. A copy of your permit application must be sent by the city/county to the appropriate branch(es) of the U.S. Military, per Government Codes 65352, 65940, and 65944.
                    
                </div>

                <div class="header" id="txt3">
              Your project location does not intersect with any military bases, special use airspaces, or low level flight paths. If you are submitting a project permit application, please provide the above information to your local planning agency as part of your permit application. A copy of your permit application for this project does not have to be sent to the U.S. Military, per Government Codes 65352, 65940, and 65944.
                    
                </div>

                 <div class="header" id="txt4">
             Your project location may intersect with the above military layers. Please provide the above information to your local planning agency as part of your permit application. A copy of your permit application must be sent by the city/county to the appropriate branch(es) of the U.S. Military, per Government Codes 65352, 65940, and 65944.
                    
                </div>

                
                <div class="body">

                    

                    
                    <div class="leftPane">
                       

                            <section>
 <%--<a href="#intro" id="intro">
<h1>Military Bases</h1>
</a>--%>
<p>
    <img src='Images/Branches2.png' />
</p>
</section>
<section>
<%--<a href="#info" id="info">
 <h1>Flight Paths</h1>
</a>--%>
<p>
 <img src='Images/Paths2.png'/>

</p>
</section>
<section>
<%--<a href="#airspace" id="airspace">
 <h1>Air Space</h1>
</a>--%>
<p>
<img src='Images/Airspace2.png'/>

</p>
</section>
<%--<section>
<%--<a href="#contact" id="contact">
<h1>County Boundaries</h1>
</a>--%>
<%--<p>
<img src="/Images/Counties.png"/>--%>

<%--</p>--%>
 <%--</section>--%>
                           
</div>
            
<input type="text" id="notetxt"/>
 <div class="mapFrame" id="map">
</div>
</div>
 <div class="mapFooter">

                     
		Copyright &copy; 2010 State of California
	
                       
                    </div>

             
<div id="GeographicArea">Report for: 

    <label id="GeoName"></label> <br/>
    <div id ="Conflictdiv">Area Contains: 
    <label id="places"></label>
    <label id="route"></label>
    <label id="special"></label>
 </div>
</div>
<br />
<div id="defaulttext"> 

    <label id="deftext"></label>
</div>
  </div>

               
        </form>
    </body>
</html>
