# 🖼️ Fragile Watermarking Using LSB for Tamper Detection and Authentication

This project demonstrates a **fragile digital image watermarking method** based on the **Least Significant Bit (LSB)** technique. In this method, a binary watermark is embedded into the LSBs of a grayscale cover image, allowing basic **tamper detection** and **image authentication**.

Unlike robust or reversible watermarking methods, this technique is **fragile** — meaning that even a small modification in the watermarked image can damage or destroy the embedded watermark. This makes it suitable for integrity verification rather than recovery or data hiding.

---

## 📌 Description

The watermark is embedded into a grayscale version of the cover image using LSB modification. This method is:

- ❗ **Fragile**: Any modification/tampering breaks the watermark.
- 🧠 **Simple and educational**: Ideal for understanding the basics of image watermarking.

---

## 📂 Project Structure

- `Main.m`: The main script that runs the watermark embedding and extraction process.
- `embedWatermark()`: Embeds binary watermark bits into the LSBs of the cover image.
- `extractWatermark()`: Extracts the watermark from the watermarked image.
- Various attack simulations (optional, commented).

---

## 🖼️ Example Images

- Cover Image: `baboon.tiff`  
- Watermark Image: `watermark.jpg`  
*(Both located in `TestImages/` folder)*

---

## 🧪 How It Works

1. **Read and preprocess** the cover and watermark images.
2. **Embed** the binary watermark into the LSB of the cover image.
3. **Measure imperceptibility** using PSNR and MSE.
4. (Optional) **Simulate attacks** like Gaussian noise, JPEG compression, rotation, etc.
5. **Extract** the watermark from the possibly attacked image.
6. **Compare** the original and extracted watermark using PSNR/MSE.

---

## 📄 Related Publications

If you're interested in the theoretical foundations and extended DWT-based version of this method, check out the following papers:

- 🎓 **Conference Paper**  
  *A Novel Reversible Fragile Watermarking in DWT Domain for Tamper Localization and Digital Image Authentication*  
  [IEEE Xplore](https://doi.org/10.1109/ISDFS52919.2021.9486339)  

- 📝 **Journal Article**  
  *A Novel Reversible Fragile Watermarking Method in DWT Domain for Tamper Localization and Digital Image Authentication*  
  [Biomedical Signal Processing and Control](https://doi.org/10.1016/j.bspc.2023.105015)

- 📘 **Book Chapter**  
  *A QR Code-Based Robust Color Image Watermarking Technique*
  In: **4th International Conference on Artificial Intelligence and Applied Mathematics in Engineering**
  [Springer](https://link.springer.com/chapter/10.1007/978-3-031-31956-3_38)

---

## 🧠 Blog

You can also read about the concept, algorithms, and implementation in more detail on my [blog page](https://github.com/azizoglu/LSBWatermarking).

---

## 🚀 Getting Started

Make sure the following files/folders exist:

- `TestImages/baboon.tiff` (Cover Image)
- `TestImages/watermark.jpg` (Watermark Image)

Then simply run:

```matlab
Main
