package com.noh.spring.common; 

import java.awt.image.BufferedImage;
import java.io.File;
import java.util.HashMap;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.pdf417.PDF417Writer;

@Service
public class GenerateBarcode {

	public void getBarcode(String cardNo, String fileName, HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("image/png;charset=utf-8");
		
		Map<EncodeHintType, Object> hintMap = new HashMap<EncodeHintType, Object>();
		hintMap.put(EncodeHintType.MARGIN, 0);
		
		PDF417Writer pdf417writer = new PDF417Writer();
	    BitMatrix bitMatrix = pdf417writer.encode(new String(cardNo.getBytes("UTF-8"), "ISO-8859-1"), BarcodeFormat.PDF_417, 150, 40, hintMap);

	    BufferedImage barcode = MatrixToImageWriter.toBufferedImage(bitMatrix);
       
        String realPath =  request.getServletContext().getRealPath("/resources/image/barcode/");
        String path = realPath + fileName + ".png";
        
        File file = new File(path);
        
        ImageIO.write(barcode, "png", file);
	}
}
