package com.giuggiola.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import org.springframework.data.jpa.repository.Query;
//import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.giuggiola.entity.Periodi_cariche;
import com.giuggiola.entity.Range2PK;
import com.vladmihalcea.hibernate.type.range.Range;
import java.time.LocalDate;
import java.util.List;



@Repository
public interface RangeRepository extends JpaRepository
<Periodi_cariche, Range2PK>{ //CrudRepository<Parlamentare,PK>
//CrudRepository<Periodi_cariche,Range2PK>{

	@Query(value="select nome from Periodi_cariche where nome=?1 order by nome",nativeQuery = true)
    public List<Periodi_cariche> findByNome(String nome);
	
	@Query(value="select * from Periodi_cariche "
		//	+ "where mandato/commissione=?1 order by mandato/commissione"
			,nativeQuery = true)
	public List<Periodi_cariche> findByMandatoCommissione(String mandato_commissione);
	
	
	@Query(value="select * from Periodi_cariche "
			//+ "where periodo_carica=?1 order by periodo_carica"
			,nativeQuery = true)
	public List<Periodi_cariche> findByPeriodo(Range<LocalDate> periodo);
	
	//@Query(value="select nome,mandato_commissione,periodo_carica from Periodi_cariche where periodo_carica=?1 order by periodo_carica", nativeQuery = true)
	//public List<Periodi_cariche> findAll();// {
	//	return 
	//}
    
	
}

