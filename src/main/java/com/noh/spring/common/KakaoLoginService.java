package com.noh.spring.common;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;

import org.springframework.stereotype.Service;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class KakaoLoginService {

	public String getAccessToken(String code) {
		String accessToken = "";
		String requestURL = "https://kauth.kakao.com/oauth/token";
		
		try {
			URL url = new URL(requestURL);
			
			HttpURLConnection conn = (HttpURLConnection)url.openConnection();
			
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);
			
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
			StringBuilder sb = new StringBuilder();
			sb.append("grant_type=authorization_code");
			sb.append("&client_id=181ac3f657f66405c58b469e8945928a");
			sb.append("&redirect_uri=http://rclass.iptime.org:9999/21PM_STARBUCKS_final/member/kakaoLogin.do");
			sb.append("&code=" + code);
			bw.write(sb.toString());
			bw.flush();
			
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line = "";
            String result = "";

            while ((line = br.readLine()) != null) {
                result += line;
            }

            JsonParser parser = new JsonParser();
            JsonElement element = parser.parse(result);

            accessToken = element.getAsJsonObject().get("access_token").getAsString();

            br.close();
            bw.close();
		} catch(IOException e) {
			e.printStackTrace();
		}
		return accessToken;
	}
	
	public String getUserInfo(String accessToken) {
        String requestURL = "https://kapi.kakao.com/v2/user/me";
        String kakaoId = "";
        String email = "";
        
        try {
            URL url = new URL(requestURL);
            HttpURLConnection conn = (HttpURLConnection)url.openConnection();
           
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Authorization", "Bearer " + accessToken);

            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));

            String line = "";
            String result = "";

            while ((line = br.readLine()) != null) {
                result += line;
                System.out.println(br.readLine());
            }
            JsonParser parser = new JsonParser();
            JsonElement element = parser.parse(result);
            log.debug("element : {}", element);
            
            kakaoId = element.getAsJsonObject().get("id").getAsString();
            log.debug("kakaoId : {}", kakaoId);
            
            JsonObject account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();
            log.debug("element.getAsJsonObject : {}", element.getAsJsonObject());

            log.debug("account : {}", account);
            email = account.getAsJsonObject().get("email").getAsString();
            
            log.debug("email : {}", email);
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return email;
    }
}
