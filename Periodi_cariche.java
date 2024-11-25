package com.giuggiola.entity;

import java.time.LocalDate;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;
import com.vladmihalcea.hibernate.type.range.PostgreSQLRangeType;
import com.vladmihalcea.hibernate.type.range.Range;


@Entity
@Table(name = "periodi_cariche")
public class Periodi_cariche extends PostgreSQLRangeType
{
	
	static final long serialVersionUID  = 1;
	/*
	@EmbeddedId
	@JoinTable(name="parlamentari",
	joinColumns={
		  @JoinColumn(name = "nome", insertable = false, updatable = false),
		  @JoinColumn(name = "partito", insertable = false, updatable = false),
		  @JoinColumn(name = "circoscrizione", insertable = false, updatable = false),
		})
    private PK pk;
	*/
	/*
	@Id
	@Column(name = "nome")
	private String nome;
	@Id
	@Column(name = "mandato/commissione")
	private String mandato_commissione;
	*/
	
	@EmbeddedId
	private Range2PK pk;
	
	private Range<LocalDate> periodo_carica;
	
	
	
	/*
	@ManyToOne(//fetch=FetchType.LAZY,
			fetch = FetchType.EAGER,
	targetEntity=Parlamentare.class)
	@JoinColumns({
		@JoinColumn(name="nome", referencedColumnName = "nome", insertable = false, updatable = false )
		,
		@JoinColumn(name="partito", referencedColumnName = "partito", insertable = false, updatable = false) 
		,
		@JoinColumn(name="circoscrizione", referencedColumnName = "circoscrizione", insertable = false, updatable = false) 
	}) 
	
	private Parlamentare parlamentare;
	
	
	private String mandato;
	
	private String commissione;
	
	@Id
	@DateTimeFormat(pattern="dd-MM-yyyy")
	private Range<LocalDate> periodo;
	
*/
	/*
	public String getMandato() {
		return mandato;
	}


	public void setMandato(String mandato) {
		this.mandato = mandato;
	}


	
	
	public String getCommissione() {
		return commissione;
	}


	public void setCommissione(String commissione) {
		this.commissione = commissione;
	}


	public Range<LocalDate> getPeriodo() {
		return periodo;
	}


	public void setRange(Range<LocalDate> periodo) {
		this.periodo = periodo;
	}
	


	public 
	Range2(
			
			) {
        
		new PostgreSQLRangeType();
       
    }
	
*/

/*
@Override
	public String toString() {
		return "Range2 [pk=" + pk + ", parlamentare=" + parlamentare +
				", mandato=" + mandato + ", commissione="
				+ commissione + ", periodo=[" + periodo.lower()+","+periodo.upper()+ "]]";
	}
*/
/*
void doInJPA(){
	
}*/
/*

@Override
public String toString() {
	return "[" + periodo.lower()+","+periodo.upper() + "]";
}
*/






	public Range2PK getPk() {
		return pk;
	}



	public void setPk(Range2PK pk) {
		this.pk = pk;
	}



	public Range<LocalDate> getPeriodo_carica() {
		return periodo_carica;
	}



	public void setPeriodo_carica(Range<LocalDate> periodo_carica) {
		this.periodo_carica = periodo_carica;
	}

	
	@Override
	public String toString() {
		return "["+pk+"periodo_carica=" + periodo_carica+ "]";
	}
/*
	public String toString2() {
		return 
	}*/

}

