clear all
clc
load("mininProcessData.mat");

%Abnormal value discrimination
  x2=table2array(MiningProcessFlotationPlantDatabase(:,2))
  x3=table2array(MiningProcessFlotationPlantDatabase(:,3))
   x4=table2array(MiningProcessFlotationPlantDatabase(:,4))


    x5=table2array(MiningProcessFlotationPlantDatabase(:,5))


   x6=table2array(MiningProcessFlotationPlantDatabase(:,6))

  x7=table2array(MiningProcessFlotationPlantDatabase(:,7))


  x8=table2array(MiningProcessFlotationPlantDatabase(:,8))


     x9=table2array(MiningProcessFlotationPlantDatabase(:,9))

     x10=table2array(MiningProcessFlotationPlantDatabase(:,10))


     x11=table2array(MiningProcessFlotationPlantDatabase(:,11))


     x12=table2array(MiningProcessFlotationPlantDatabase(:,12))


     x13=table2array(MiningProcessFlotationPlantDatabase(:,13))


     x14=table2array(MiningProcessFlotationPlantDatabase(:,14))

     x15=table2array(MiningProcessFlotationPlantDatabase(:,15))

     x16=table2array(MiningProcessFlotationPlantDatabase(:,16))


     x17=table2array(MiningProcessFlotationPlantDatabase(:,17))


     x18=table2array(MiningProcessFlotationPlantDatabase(:,18))


     x19=table2array(MiningProcessFlotationPlantDatabase(:,19))


     x20=table2array(MiningProcessFlotationPlantDatabase(:,20))


     x21=table2array(MiningProcessFlotationPlantDatabase(:,21))
   
     x22=table2array(MiningProcessFlotationPlantDatabase(:,22))
  

   x23=table2array(MiningProcessFlotationPlantDatabase(:,23))


   x24=table2array(MiningProcessFlotationPlantDatabase(:,24))

   boxplot([x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16,x17,x18,x19,x20,x21,x22,x23,x24],{"IronFeed", "SilicaFeed", "StarchFlow", "AminaFlow", "OrePulpFlow", "OrePulpPH", "OrePulpDensity", ...
       "FlotationColumn01AirFlow", "FlotationColumn02AirFlow", "FlotationColumn03AirFlow", ...
       "FlotationColumn04AirFlow", "FlotationColumn05AirFlow", "FlotationColumn06AirFlow", ...
       "FlotationColumn07AirFlow", "FlotationColumn01Level", "FlotationColumn02Level", ...
       "FlotationColumn03Level", "FlotationColumn04Level", "FlotationColumn05Level", ...
       "FlotationColumn06Level", "FlotationColumn07Level", "IronConcentrate", "SilicaConcentrate"})

