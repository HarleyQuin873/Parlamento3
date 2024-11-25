package com.giuggiola.repository;

//import java.util.ArrayList;

import java.util.List;

//import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

//import javax.persistence.NamedNativeQueries;
//import javax.persistence.NamedNativeQuery;
//import javax.persistence.NamedQueries;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
//import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import com.giuggiola.entity.PK;
import com.giuggiola.entity.Parlamentare;

//@Document()
@Repository
public interface ParlamentareRepository extends// ElasticsearchRepository<Parlamentare,PK>{
JpaRepository<Parlamentare, PK>{ //CrudRepository<Parlamentare,PK>

	@Query(value="select nome from Parlamentari where nome=?1 order by nome",nativeQuery = true)
    public Parlamentare findByNome(String nome);
    
	
    @Query(value="select pk from Parlamentari where nome=?1, partito=?1, circoscrizione=?1 order by pk",nativeQuery = true)
    public Parlamentare findByPk(PK pk);
    
    /*
    @Query(value="select * from Parlamentari where nome=?1 and partito=?2 and circoscrizione=?3", nativeQuery= true)
    public Parlamentare findByPkk(String nome, String partito, String[] circoscrizione);
	*/
    
    
	
    @Query(value="select nome from Parlamentare where partito=?1 order by nome",nativeQuery = true)
	public List<Parlamentare> findByPartito(String partito);
	
    
    
    /*@NamedQueries({ @NamedQuery(name = "findUserByName", query = "from User u where u.name= :name") })

    @NamedNativeQueries({ @NamedNativeQuery(name = "findUserByNameNativeSQL", query = "select * from users u where u.name= :name", resultClass = User.class) })*/
    
	//@Query(value="select nome from Parlamentari where circoscrizione IN (:circoscrizionee) order by nome")//,nativeQuery =false)
    //Query("FROM Parlamentare P where P.pk.circoscrizione= :circoscrizionee")
    @Query("FROM Parlamentare P where P.pk.circoscrizione= :circoscrizionee")
	public List<Parlamentare> findByCircoscrizione(String circoscrizionee);//{
 //   public List<Parlamentare> findByCircoscrizione(@Param(value="circoscrizione") String circoscrizionee);//{
	//public List<Parlamentare> findByCircoscrizione(@Param(value="circoscrizione") String[] circoscrizionee);//{
	//public List<Parlamentare> findByCircoscrizione(@Param(value="circoscrizionee") String[] circoscrizionee);//{
	//public List<Parlamentare> findByCircoscrizione(@Param(value="circoscrizionee") List circoscrizionee);//{
	//	public List<Parlamentare> findByCircoscrizione(@Param(value="circoscrizionee") String[] circoscrizionee);//{
	/**/
	
	/*String qiString = "select item from Item where item.name IN (:names)";
	 * 
	 * List<String >names = Array.asList("foo","bar")*/
	
	/*@Query(value="select * from student where roll_no in (:rollNos)",native =true)
	List<Object[]> selectStudents(@Param("rollNos") List<Integer> rollNos);*/
	
}

