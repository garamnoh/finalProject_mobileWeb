package com.noh.spring.common; 

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Service;

@Service
public class ConvertAddrToCoordinate {
	
	public HashMap<String, String> getCoordinate(String address){
		
		HashMap<String, String> coordinate = new HashMap<String, String>();
		
		String requestURL = "http://dapi.kakao.com/v2/local/search/address.json?query=";
		String restApiKey = "KakaoAK 181ac3f657f66405c58b469e8945928a";
		
		try {
			address = URLEncoder.encode(address, "UTF-8");
			
			URL url = new URL(requestURL + address);
			HttpURLConnection conn = (HttpURLConnection)url.openConnection();
			
			conn.setRequestMethod("GET"); 
			conn.setRequestProperty("Authorization", restApiKey); 
			conn.setRequestProperty("content-type", "application/json"); 
			conn.setDoOutput(true); 
			
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String line = "";
			String result = "";
			
			while((line = br.readLine()) != null) {
				result += line;
			}
			
			JSONParser parser = new JSONParser();
			JSONObject jsonObj1 = (JSONObject)parser.parse(result);
			Object obj = jsonObj1.get("documents");
			
			JSONArray jsonArray = (JSONArray)obj;
			
			JSONObject jsonObj2 = (JSONObject)jsonArray.get(0);
			String addr = jsonObj2.get("address").toString();
			
			JSONObject jsonObj = (JSONObject)parser.parse(addr);
			System.out.println(jsonObj.get("y").toString());
			System.out.println(jsonObj.get("x").toString());
			coordinate.put("latitude", jsonObj.get("y").toString());
			coordinate.put("longitude", jsonObj.get("x").toString());
			
		} catch(Exception e) {
			e.printStackTrace();
		}
			
		return coordinate;
	}
}
