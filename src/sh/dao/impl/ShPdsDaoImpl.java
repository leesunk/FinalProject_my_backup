package sh.dao.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import sh.dao.ShPdsDao;
import sh.model.ShBbsParam;
import sh.model.ShPdsDto;

@Repository
public class ShPdsDaoImpl implements ShPdsDao {


	@Autowired
	SqlSession sqlSession;
	
	String ns = "ShPds.";
	
	@Override
	public List<ShPdsDto> getShPdsList() {
		return sqlSession.selectList(ns + "getPdsList");
	}

	@Override
	public boolean uploadPds(ShPdsDto dto) {
		int n = sqlSession.insert(ns + "uploadPds", dto);
		return n>0?true:false;		//3�׿����ھ� ! ũ�� true�� ��ȯ
	}
	
	@Override
	public ShPdsDto getPds(int seq) {
		return sqlSession.selectOne(ns + "getPds", seq);
	}

	@Override
	public boolean updatePds(ShPdsDto dto) {
		int n = sqlSession.update(ns + "updatepds", dto);		//�ٲ�� int������ �����鼭 �ٲ�������� Ȯ��
		return n>0?true:false;	//�������� 1�� true�� ��.
	}

	
	/* �ణ�� ������ �ʿ��� */
	
	@Override
	public List<ShPdsDto> getBbsPagingList(ShBbsParam param) {
		return sqlSession.selectList(ns + "getBbsPagingList", param);
	}

	@Override
	public int getBbsCount(ShBbsParam param) {
		return sqlSession.selectOne(ns + "getBbsCount", param);
	}
	
	@Override
	public boolean readcountUpdate(ShPdsDto dto) {
		int count = sqlSession.update(ns + "readcountUpdate", dto);
		return count>0?true:false;
	}

	@Override
	public void deleteBbs(int seq) throws Exception {
		sqlSession.selectOne(ns + "deleteBbs", seq);
	}
	
}
