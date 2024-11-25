package com.giuggiola.entity;

import java.io.Serializable;
//import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
//import java.util.List;
import java.util.Objects;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;
import org.hibernate.annotations.Type;
import org.hibernate.annotations.TypeDef;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import com.vladmihalcea.hibernate.type.array.ListArrayType;
import com.vladmihalcea.hibernate.type.array.StringArrayType;
import com.vladmihalcea.hibernate.type.range.PostgreSQLRangeType;
import com.vladmihalcea.hibernate.type.range.Range;
import lombok.AllArgsConstructor;
import lombok.Data;

@Component
@Entity
@Table(name = "parlamentari")
@Data
@AllArgsConstructor
@TypeDef(
	    typeClass = PostgreSQLRangeType.class,
	    defaultForType = Range.class
	)
@TypeDef(
	    name = "list-array",
	    typeClass = ListArrayType.class
	)
@TypeDef(
        name = "string-array", 
        typeClass = StringArrayType.class
    )
public class Parlamentare implements Serializable{
	
	static final long serialVersionUID = 1;
	
	@EmbeddedId
	private PK pk;
	
	@Column(name = "data_nascita")
	 Date data_nascita; 
	
	@Column(name = "luogo")
     String luogo; 
	
	@Column(name = "titolo_studi")
     String titolo_studi;
	
	
	@Type( type = "string-array" )
    @Column(
        name = "mandati", 
        columnDefinition = "text[]"
    )
    private String[] mandati;
	
	@Type( type = "string-array" )
    @Column(
        name = "commissioni", 
        columnDefinition = "text[]"
    )
    private String[] commissioni;
	
	
	
  /*
	@NotFound(action = NotFoundAction.IGNORE)
	@OneToMany(mappedBy="parlamentare",  cascade=CascadeType.ALL, orphanRemoval=true, targetEntity=Range2.class)
	  @Type(type = "list-array")
	    @Column(
	        name = "periodi_cariche",
	        columnDefinition = "daterange[]"
	    )
	 	private List<Range<LocalDate>> periodi_cariche = new ArrayList<Range<LocalDate>>();
	  
*/
	
	
	
	
	public Parlamentare() {
		super();
		// TODO Auto-generated constructor stub
	}

	@Autowired
	public String getNome() {
		return pk.nome;
	
	}

	/*
	public Parlamentare(PK pk, Date data_nascita, String luogo, String titolo_studi, String[] mandati,
			String[] commissioni) {
		super();
		this.pk = pk;
		this.data_nascita = data_nascita;
		this.luogo = luogo;
		this.titolo_studi = titolo_studi;
		this.mandati = mandati;
		this.commissioni = commissioni;
	}*/

	@Autowired
	public void setNome(String nome) {
		this.pk.nome = nome;
	
	}

	@Autowired
	public String getPartito() {
		return pk.partito;
	}

	@Autowired
	public void setPartito(String partito) {
		this.pk.partito = partito;
	
	}

	@Autowired
	public String[] getCircoscrizione() {
		return pk.getCircoscrizione();
	
	}

	@Autowired
	public void setCircoscrizione(String[] circoscrizione) {
		this.pk.setCircoscrizione(circoscrizione);
	
	}

	public String getpk(String nome,String partito,String[] circoscrizione) {
		String pk = null;
		if(nome == this.getNome() ) 
				if(partito == this.getPartito()) 
					if(circoscrizione == this.getCircoscrizione())
						pk = nome + ","+ partito + "," + circoscrizione;
		return pk;
	}
	
	public void setpk(String nome,String partito,String[] circoscrizione){
		
		this.pk.nome=nome;
		this.pk.partito=partito;
		this.pk.setCircoscrizione(circoscrizione);
	}
	
	@Autowired
	public Date getData_nascita() {
		return data_nascita;
	}

	@Autowired
	public void setData_nascita(Date data_nascita) {
		this.data_nascita = data_nascita;
	}

	@Autowired
	public String getLuogo() {
		return luogo;
	}

	@Autowired
	public void setLuogo(String luogo) {
		this.luogo = luogo;
	}

	@Autowired
	public String getTitolo_studi() {
		return titolo_studi;
	}

	@Autowired
	public void setTitolo_studi(String titolo_studi) {
		this.titolo_studi = titolo_studi;
	}

	@Autowired
	public String[] getMandati() {
		return mandati;
	}

	@Autowired
	public void setMandati(String[] mandati) {
		this.mandati = mandati;
	}

	@Autowired
	public String[] getCommissioni() {
		return commissioni;
	}

	@Autowired
	public void setCommissioni(String[] commissioni) {
		this.commissioni = commissioni;
	}	
	
	/*
	@Autowired
	public List<Range<LocalDate>> getPeriodi_cariche() {
		return periodi_cariche;
	}

	@Autowired
	public void setPeriodi_cariche(List<Range<LocalDate>> periodi_cariche) {
		this.periodi_cariche = periodi_cariche;
	}
	*/
	public boolean isEmpty() {
		
		if (this.pk == null)
		   return true;
		else 
		   return false;
	}

	@Override
	public boolean equals(Object o) {
		if ( this == o ) {
			return true;
		}
		if ( o == null || getClass() != o.getClass() ) {
			return false;
		}
		PK pk1 = (PK) o;
		if (pk.nome != pk1.nome) return false;
        return pk.partito == pk1.partito;
        
	}

	@Override
	public int hashCode() {
		return Objects.hash(pk.nome, pk.partito, pk.getCircoscrizione());
	
	}

	@Override
	public String toString() {
		return "["+ pk + ", data_nascita=" + data_nascita + ", luogo=" + luogo + ", titolo_studi="
				+ titolo_studi + ", mandati=" + Arrays.toString(mandati) + ", commissioni="
				+ Arrays.toString(commissioni) + "]";
	}	
	
}



