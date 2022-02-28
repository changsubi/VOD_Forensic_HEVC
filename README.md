## Real-Time DRM & Forensic Marking Method based on CUDA Parallel Processing
This project proposes a real-time DRM and forensic mark technology based on the HEVC/MPEG-H Part.2(H.265) standards. This technology ,on a GPU multi-core basis, utilizes the Entropy Coding technology only to approach the QTC (Quantified Transform Coordinators) area and inserts the mark by applying the XOR operation to the n-bits of the forensic mark bitstream and the key based pseudo random n-bits. Compared to the previous researches, the PSNR was 10dB higher, and the insertion speed increased by 70 times at 8K and 13 times at 4K. And robustness shows an average of 84.37% in 8K video.
## Demo Video
https://user-images.githubusercontent.com/100255173/155906151-706fbc01-6436-4b74-9dd1-5b80e2d2bb35.mp4
## Streaming Web Service
![그림2](https://user-images.githubusercontent.com/100255173/155906305-d1c402cf-8843-4117-a18c-b2eeb699af9f.png)
It is a VOD (Video On Demand) streaming service with copyright protection technology applied.
First, creators must register as a member to upload their content.
Upon registration, the administrator gives the creators an account with access to the web and an account with access to the forensic mark management database.
Creators can create their own channels by logging in and upload content to the channel.
DRM and forensic marks are inserted in the uploaded content in real time when you play the content for the first time.

In the forensic marking process, the bitstream generated by the forensic mark generator is first stored in the forensic mark management DB and the original QTC key stream is stored in the QTC storage.
After that, the insertion process proceeds by reading the mark information from the forensic mark management DB.
DRM packaging is processed simultaneously with forensic mark insertion.

Users will watch content embedded with these two technologies.
![그림3](https://user-images.githubusercontent.com/100255173/155907436-811c2d1a-32ca-4d28-8e4c-c33db4c5d1d5.png)
![그림4](https://user-images.githubusercontent.com/100255173/155907440-5df4994f-a43c-4abd-8e2c-cdf878bc98ad.png)
Content purchase process and verification process.
There are two methods for this process.
The first is to verify the website itself, and the second is to verify it using a verification program without accessing the website.

The purchase process is currently with the billing library function turned off, so members can download it right away. (You can use the billing policy library if necessary) Downloaded content is converted to HEVC for copyright verification later and is downloaded. The verification process includes DRM unpackaging and forensic mark extraction.
