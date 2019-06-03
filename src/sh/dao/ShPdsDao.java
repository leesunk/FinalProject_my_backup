package sh.dao;

import java.util.List;

import sh.model.ShBbsParam;
import sh.model.ShNbbsDto;
import sh.model.ShPdsDto;

public interface ShPdsDao {
	
	public List<ShPdsDto> getShPdsList();		//����Ʈ �ѷ��ֱ�
	
	public boolean uploadPds(ShPdsDto dto);		//���� ���ε�
	
	public ShPdsDto getPds(int seq);			//������
	
	public boolean updatePds(ShPdsDto dto);		//����
	
	public List<ShPdsDto> getBbsPagingList(ShBbsParam param);
	
	public int getBbsCount(ShBbsParam param);
	
	public boolean readcountUpdate(ShPdsDto dto); 

	void deleteBbs(int seq) throws Exception;
	
}
