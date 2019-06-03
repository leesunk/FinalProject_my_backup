package sh.controller;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;


import sh.model.ShBbsParam;
import sh.model.ShNbbsDto;
import sh.model.ShPdsDto;
import sh.service.ShPdsService;
import sh.util.FUpUtil;

@Controller
public class ShPdsController {

	private static final Logger logger
	 = LoggerFactory.getLogger(ShPdsController.class);
	
	@Autowired
	ShPdsService ShPdsService;
	
	@RequestMapping(value="pdslist.do", method={RequestMethod.GET, RequestMethod.POST})
	public String pdslist(Model model, ShBbsParam param) {
		
		logger.info("ShPdsController pdslist " + new Date());
		
		//paging ó��
		int sn = param.getPageNumber();
		int start = (sn) * param.getRecordCountPerPage() + 1;
		int end = (sn+1) * param.getRecordCountPerPage();
		
		param.setStart(start);
		param.setEnd(end);
		
		List<ShPdsDto> list = ShPdsService.getShPdsList();
		
		List<ShPdsDto> pdslist = ShPdsService.getBbsPagingList(param);
		//���� �� ����
		int totalRecordCount = ShPdsService.getBbsCount(param);
		
		model.addAttribute("pdslist", pdslist);
		
		model.addAttribute("pageNumber", sn);
		model.addAttribute("pageCountPerScreen", 10);
		model.addAttribute("recordCountPerPage", param.getRecordCountPerPage());
		model.addAttribute("totalRecordCount", totalRecordCount);
		
		model.addAttribute("s_category", param.getS_category());
		model.addAttribute("s_keyword", param.getS_keyword());
		
		return "pdslist.tiles";
		
	}
	
	@RequestMapping(value="pdswrite.do", method={RequestMethod.GET, RequestMethod.POST})
	public String pdswrite(Model model) {
		logger.info("ShPdsController pdswrite " + new Date());
		
		return "pdswrite.tiles";
	}
	
	@RequestMapping(value="pdsupload.do", method={RequestMethod.GET, RequestMethod.POST})
	public String pdsupload(ShPdsDto pdsdto,
							@RequestParam(value="fileload", required=false)MultipartFile fileload,
							HttpServletRequest req) {
	
		//	@RequestParam ������̼��� �̿��� �Ķ���� ����
		// �Ķ���� fileload�� �������� ������ null������ ����
		logger.info("ShPdsController pdsupload " + new Date());
		
		//filename�� ���
		String filename = fileload.getOriginalFilename();
		pdsdto.setFilename(filename);
		
		//upload ���
		//tomcat
		String fupload = req.getServletContext().getRealPath("/upload");
		
		//file(d����̺� tmp ������ �ۼ���
		//String fuplad = "d:\\tmp";
		
		//���ϸ�.xxx -> 12232132.xxx
		String f = pdsdto.getFilename();	//���� ���� ������ set�� ���ְ� get�� ��������
		String newfilename = FUpUtil.getNewFile(f);		//������ newfilename�� �־��
		
		pdsdto.setFilename(newfilename);
		

		File file = new File(fupload + "/" + newfilename);
		System.out.println("upload ���ϰ��:" + fupload + "/" + newfilename);
		
		try {
			//���� ���� ���ε� �κ�
			FileUtils.writeByteArrayToFile(file, fileload.getBytes());	//����Ʈ ������ �����ҰŶ�
				
			//db ����
			ShPdsService.uploadPds(pdsdto);
				
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "redirect:/pdslist.do";			
			
	}
	
	@RequestMapping(value="fileDownload.do", method={RequestMethod.GET, RequestMethod.POST})
	public String fileDownload(String filename, int seq,
							HttpServletRequest req, Model model) {
		logger.info("ShPdsController fileDownload " + new Date());
		
		// download ���
		// tomcat
		String fupload = req.getServletContext().getRealPath("/upload");
			
		// file
		// String fupload = "d:\\tmp";
		
		File downloadFile = new File(fupload + "/" + filename);
		
		model.addAttribute("downloadFile", downloadFile);
		model.addAttribute("seq", seq);
		
		return "downloadView";	//�̰� ���� ���ĸ� ������ �������� servlet-context���� �� �ִ��� Ȯ���ϸ� ��!!
		
	}
	
	@RequestMapping(value="pdsdetail.do", method={RequestMethod.GET, RequestMethod.POST})
	public String pdsdetail(int seq, ShPdsDto dto, Model model) {
		logger.info("ShPdsController pdsdetail " + new Date());
		model.addAttribute("doc_title", "�ڷ� ����");
		
		//readcount �߰�
		
		//dto�� ���
		ShPdsDto pdsdto = ShPdsService.getPds(seq);
		
		boolean isS = ShPdsService.readcountUpdate(dto);
		if(isS) {
			logger.info("ShPdsController pdsdetail readcountUpdate Success " + new Date());
		} else {
			logger.info("ShpdsController pdsdetail readcountUpdate Fail! " + new Date());
		}
		
		model.addAttribute("pds", pdsdto);
		
		System.out.println(pdsdto);
		
		return "pdsdetail.tiles";
	}
	
	@RequestMapping(value="pdsupdate.do", method={RequestMethod.GET, RequestMethod.POST})
	public String pdsupdate(int seq, Model model) {
		
		logger.info("ShPdsController pdsupdate " + new Date());
		model.addAttribute("doc_title", "�ڷ� ����");
		//value��ü�� name�̸����� �߰��Ѵ�, �� �ڵ忡���� name���� ������ �̸��� ���ؼ� value�� ����Ѵ�.
		//Ȥ�� model.addAttribute�� ���� ���ذ� �����ϸ� model�� pds���� ���� ���� �ž� 
		
		ShPdsDto pdsDto = ShPdsService.getPds(seq);
		model.addAttribute("pds", pdsDto);
		
		return "pdsupdate.tiles";
	}
	
	@RequestMapping(value="pdsupdateAf.do", method={RequestMethod.GET, RequestMethod.POST})
	public String pdsupdateAf(ShPdsDto pdsdto,
								String namefile,		//������ ���ϸ�
			 					HttpServletRequest req,	//��û���ؼ�
								@RequestParam(value = "fileload", required=false)
								MultipartFile fileload) {
		
	//RequestParam�� ���� ���� ������ fileload(�Ķ�����̸�) Ű ���� false�� ������ ��� badRequest�� �߻����� �ʴ´�.
		System.out.println("ShPdsController pdsupdateAf" + new Date());
		System.out.println(pdsdto.toString());
		System.out.println(namefile);		
	//	System.out.println(fileload.getOriginalFilename());
		
	//	pdsdto.setFilename(fileload.getOriginalFilename());
		//������ �Ű������� pdsdto�� ���س���!!
		
		//���ϰ�� ���
		String fupload = req.getServletContext().getRealPath("/upload");
		
		//������ ���� ����
		if(pdsdto.getFilename() != null && !pdsdto.getFilename().equals("")) {
		//���� pdsdto���� get�� �޾ƿ� filename�� null�� �ƴϰ� get���� ������ filename�� ������ �ƴϿ��� �Ѵ�	
			
			String f = pdsdto.getFilename();		//���� ������ String Ÿ�� f�� �ְ�
			String newfile = FUpUtil.getNewFile(f);	//���⼭ ���� ��ƿ�� ���ؼ� ����ȴٰ� �����
			
			pdsdto.setFilename(newfile);
			
			File file = new File(fupload + "/" + newfile);	//�̰Ŵ� ��ü�� �����ؼ� ���ο� �̸����� ������ ���� ��θ� ���� 
			//������ ���ε�
			
			try {
				FileUtils.writeByteArrayToFile(file, fileload.getBytes());
				
				//db ����(service�� ������ �ϴ� ���̶�� ������)
				ShPdsService.update(pdsdto);
				
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		//������ ������ ������
		else {
			//������ ���� ������ ����
			pdsdto.setFilename(namefile);		//�Ű������� ������ ���� ��� �����ϴٰ� ���
			
			//DB
			ShPdsService.update(pdsdto);
		}
		
		return "redirect:/pdslist.do";
	}
	
	@RequestMapping(value = "pdsdelete.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String deleteBbs(int seq, Model model) throws Exception {
		logger.info("ShPdsController deleteBbs " + new Date());
		ShPdsService.deleteBbs(seq);
		return "redirect:/pdslist.do";
	}
	
}
