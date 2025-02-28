# MSR
Multiscale and Recursive Unmixing of Spatiotemporal Rhythms for Live-Cell and Intravital Cardiac Microscopy

While fluorescence microscopy is an invaluable tool for probing biological processes, cardiovascular signals are often complicated by persistent autofluorescence, overlaying dynamic cardiovascular entities, and non-specific labeling from tissue microenvironments. In response, this study presents multi-scale recursive decomposition (MSR), an algorithm for the precise extraction of dynamic cardiovascular signals. MSR constructs a comprehensive framework for cardiac microscopy that includes pixel-wise image enhancement, robust principal component analysis, and recursive motion segmentation. 

Step 1:
Navigate to 20230410_22/Util/ and run B56_FLF016X080V20_PrePro.m to generate light-field images with background subtraction, cropping, denoising, and decomposition into various channels.

  1. FLF_Location.tif – A reference image of the star target, captured using the Fourier Light-Field Microscope (FLFM), used to define the microlens array border for cropping.
    Place FLF_Location.tif in MSR_code_1/20230410_22/.
    Alternatively, use raw data from 5FLFVid_2expraw04/, renaming it accordingly.
  2. The script generates folders for intermediate images, used for extracting dynamic signals from the static background and reconstructing volumetric Fourier light-field images.
    These folders already exist in the designated directory.
    Images capturing multiple continuous cardiac cycles are acquired and stored in the 5FLFVid_2expraw<order>/ directory. Datasets for the paper are available from the corresponding author upon request due to the large file size.
  4. The raw data is cropped to the ideal size for analysis.
  5. Cross-correlation value is calculated for all the image sequences with the first image to determine the nodes for each beating cycle.
  6. Denoising is applied to the elemental image stack for one beating cycle using the MIRO (https://github.com/ShuJiaLab/MIRO) algorithm in both spatial and temporal domains.
  7. The denoised image stack is decomposed into a sparse component containing moving cells and a low-rank component containing the static background. 

Alternatively, navigate to 20230410_22/Util/ and run CFM_util.m to apply the MSR algorithm on standard non-light-field fluorescence images. Datasets for the demo will be uploaded to https://figshare.com/projects/MSR_for_Cardiac_Microscopy/239177 due to the large file size.

Step 2:  
Navigate to 20230410_22/Util/ and run flim.m to determine the nodes of the beating cycle for denoise and decomposition.
An additional frame interpolation step is required for the pseudo-two-color decomposition of light-field images with two cell types stained with the same color, e.g., the red blood cells and cardiomyocytes across the heart. 

  1. Appropriate frame interpolation times can be conducted through the repository https://github.com/google-research/frame-interpolation.
  2. Correlation analysis is applied similarly to identify systolic and diastolic points, which serve as reference regions for denoising and decomposition.
  3. First-round decomposition is conducted to separate moving cells from the static autofluorescence background, following the same procedure as in Step 1.
  4. Second-round decomposition is applied to the extracted moving cell images, further distinguishing randomly moving blood cells from cardiomyocytes.
     
Step 3:
Please run C58_Reconstruction.m for the volumetric reconstruction of the decomposed light-field images. Guidance can be found at https://github.com/ShuJiaLab/Organoid_FLFM 
