package sh.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import sh.dao.ShPollDao;
import sh.model.ShPollBean;
import sh.model.ShPollDto;
import sh.model.ShPollSubDto;
import sh.model.ShVoter;
import sh.service.ShPollService;

@Service
public class ShPollServiceImpl implements ShPollService {

	@Autowired
	ShPollDao shPollDao;
	
	@Override
	public List<ShPollDto> getPollAllList(String id) {
		
		//��� ��ǥ ����� ���� �´�
		List<ShPollDto> list = shPollDao.getPollAlllist();
		
		//��ǥ�� �� �� �ִ� �׸�� ���� �׸����� ���� ���(�޸𸮿� �������ֱ� ������ ���Ӱ� ���� �ۼ�)
		List<ShPollDto> plist = new ArrayList<ShPollDto>();
		
		
		for(ShPollDto poll : list) {
			int pollid = poll.getPollid(); //��ǥ��ȣ
			
			int count = shPollDao.isVote(new ShVoter(pollid, -1, id));		//pollid ����. db�� �����ڳ���. ->seq in//voterdao
			if(count == 1) {	// ��ǥ�� ����
				poll.setVote(true);
			}
			else {	// ��ǥ�� ������
				poll.setVote(false);				
			}
			
			plist.add(poll);
		}
		
		return plist;
			
			
	}

	@Override
	public void makePoll(ShPollBean pbean) {
/*		java.sql.Date sDate = new java.sql.Date(pbean.getSdate().getTime());
		java.sql.Date eDate = new java.sql.Date(pbean.getEdate().getTime());*/
		
		//질문 항목(매개 변수 만들어 놨음 ShPollDto에)
		ShPollDto poll = new ShPollDto(pbean.getId(),			//투표 만든 사람의 ID
										pbean.getQuestion(),	//질문
										pbean.getSdate(),		//시작일
										pbean.getEdate(),		//종료일
										pbean.getItemcount(), 0);	//보기의 갯수, 질문에 투표한 사람의 수( )
		
		//DB insert
		shPollDao.makePoll(poll);
		
		//�����
		int itemcount = pbean.getItemcount();		//������ ����
		String answer[] = pbean.getPollnum();		//�� ������ ������ �ִ� 10���� �迭�� ��ü�� �����ؼ� ����� ����(�����)
		
		for (int i = 0; i < itemcount; i++) {
			ShPollSubDto pollsub = new ShPollSubDto();
			pollsub.setAnswer(answer[i]);		//for�� ���鼭 set���� ������ ������ �亯���� �Ұž�
			shPollDao.makePollSub(pollsub);
		}
		
	}

	@Override
	public ShPollDto getPoll(ShPollDto poll) {
		return shPollDao.getPoll(poll);
	}

	@Override
	public List<ShPollSubDto> getPollSubList(ShPollDto poll) {
		return shPollDao.getPollSubList(poll);
	}

	@Override
	public void polling(ShVoter voter) {
		shPollDao.pollingVoter(voter);		//��ǥ �Ѵ����� ����� ����
		shPollDao.pollingPoll(voter);		//��Ż �÷���
		shPollDao.pollingSub(voter);		//��� ��ǥ�ߴ��� acount �� �ϳ� �÷���
	}

}
