# MSR
Multiscale and Recursive Unmixing of Spatiotemporal Rhythms for Live-Cell and Intravital Cardiac Microscopy

While fluorescence microscopy is an invaluable tool for probing biological processes, cardiovascular signals are often complicated by persistent autofluorescence, overlaying dynamic cardiovascular entities, and non-specific labeling from tissue microenvironments. In response, this study presents multi-scale recursive decomposition (MSR), an algorithm for the precise extraction of dynamic cardiovascular signals. MSR constructs a comprehensive framework for cardiac microscopy that includes pixel-wise image enhancement, robust principal component analysis, and recursive motion segmentation. 

Step 1:
Please go to 20230410_22/Util/ to run B56_FLF016X080V20_PrePro.m to generate light-field images that are subtracted background, cropped, denoised, and decomposed into various channels.

  FLF_Location.tif is the image of the star target imaged with the FLFM to define the border of the microlens array for the cropping 
  please place it under MSR_code_1\20230410_22\

  
Step 2:
Please run C58_Reconstruction.m for the volumetric reconstruction of the sequences. 
