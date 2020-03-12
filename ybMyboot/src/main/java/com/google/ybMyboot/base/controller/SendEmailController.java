package com.google.ybMyboot.base.controller;
//package com.google.ybiBatis.base.controller;
//
//import java.sql.Connection;
//import java.util.HashMap;
//import java.util.Properties;
//
//import javax.activation.DataHandler;
//import javax.activation.DataSource;
//import javax.activation.FileDataSource;
//import javax.mail.BodyPart;
//import javax.mail.Message;
//import javax.mail.Multipart;
//import javax.mail.PasswordAuthentication;
//import javax.mail.Session;
//import javax.mail.Transport;
//import javax.mail.internet.InternetAddress;
//import javax.mail.internet.MimeBodyPart;
//import javax.mail.internet.MimeMessage;
//import javax.mail.internet.MimeMultipart;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//
//import org.springframework.web.servlet.ModelAndView;
//import org.springframework.web.servlet.mvc.multiaction.MultiActionController;
//
//import com.google.ybiBatis.common.transaction.DataSourceTransactionManager;
//
//import net.sf.jasperreports.engine.JasperCompileManager;
//import net.sf.jasperreports.engine.JasperExportManager;
//import net.sf.jasperreports.engine.JasperFillManager;
//import net.sf.jasperreports.engine.JasperPrint;
//import net.sf.jasperreports.engine.JasperReport;
//
//public class SendEmailController extends MultiActionController{
//  
//    private Multipart multipart;
//    
//    public ModelAndView sendEmail(HttpServletRequest request, HttpServletResponse response) {
//       HashMap<String, Object> parameters = new HashMap<>();
//       parameters.put("empCode", request.getParameter("empCode"));
//       parameters.put("usage", request.getParameter("usage"));
//       parameters.put("date", request.getParameter("requestDay"));
//       parameters.put("end", request.getParameter("useDay"));
//       
//       String eMail = request.getParameter("eMail");
//
//       String host = "smtp.naver.com";
//       final String user = "seoulittest1"; 
//       final String password = "testtest1";
//       int port = 465;
//       
//       String recipient = eMail; //받는 사람의 메일주소를 입력해주세요
//       String subject = "메일테스트"; //메일 제목 입력해주세요.
//       String body = user+"님으로 부터 메일을 받았습니다."; //메일 내용 입력해주세요.
//
//       
//       String toAddress = eMail;
//
//       JasperReport jasperReport;
//       JasperPrint jasperPrint;
//       try {
//
//          jasperReport = JasperCompileManager.compileReport("C:\\Program Files\\Apache Software Foundation\\Tomcat 9.0\\webapps\\ybiBatis\\report\\employment.jrxml");
//   
//          jasperPrint = JasperFillManager.fillReport(jasperReport, parameters, con);
//          JasperExportManager.exportReportToPdfFile(jasperPrint, "C:\\Users\\cyeon\\springBoot_workspace\\ybiBatis\\report\\empReport.pdf");
//
//          // Get the session object
//          Properties props = new Properties();
//          props.put("mail.smtp.host", host);
//          props.put("mail.smtp.port", port);
//          props.put("mail.smtp.auth", "true");
//          props.put("mail.smtp.ssl.enable", "true");
//          props.put("mail.smtp.ssl.trust", host);
//
//
//          Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
//             protected PasswordAuthentication getPasswordAuthentication() {      
//                return new javax.mail.PasswordAuthentication(user, password);
//             }
//          });
//           MimeMessage message = new MimeMessage(session);
//             message.setFrom(new InternetAddress("seoulittest1@naver.com"));  
//             message.addRecipient(Message.RecipientType.TO, new InternetAddress(toAddress));
//           System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@toAddress:   "+toAddress);
//             // Subject
//             message.setSubject("제목: 메일 전송(아이리포트)");
//             multipart = new MimeMultipart();
//                   
//             // Text
//             MimeBodyPart mbp1 = new MimeBodyPart();
//                mbp1.setText("본문내용 : 메일 전송(아이리포트)");
//                multipart.addBodyPart(mbp1);
//
//             // send the message
//             //if(fileName != null){
//                   DataSource source = new FileDataSource("C:\\Program Files\\Apache Software Foundation\\Tomcat 9.0\\webapps\\ybiBatis\\report\\empReport.pdf");
//                   BodyPart messageBodyPart = new MimeBodyPart();
//                   messageBodyPart.setDataHandler(new DataHandler(source));
//                   messageBodyPart.setFileName("test.pdf");
//                   multipart.addBodyPart(messageBodyPart);
//             //  }
//             message.setContent(multipart);
//                Transport.send(message);
//             System.out.println("메일 발송 성공!");
//
//       } catch (Exception e) {
//          e.printStackTrace();
//          System.out.println("메일에러" + e);
//       }
//       return null;
//    }
//}
