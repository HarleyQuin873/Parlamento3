package com.giuggiola.entity;

import java.io.Serializable;
//import java.util.ArrayList;
import java.util.Arrays;
//import java.util.List;
import java.util.Objects;
import javax.persistence.Column;
import javax.persistence.Embeddable;
import org.hibernate.annotations.Type;
import org.hibernate.annotations.TypeDef;
import org.springframework.stereotype.Component;
import com.vladmihalcea.hibernate.type.array.StringArrayType;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
//import org.springframework.data.elasticsearch.annotations.Document;

//@Document("")
@Component
@Data
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode
@Embeddable
@TypeDef(
        name = "string-array", 
        typeClass = StringArrayType.class
    )
public class PK implements Serializable {
	
	private static final long serialVersionUID = 1;
	
    @Column(name="nome", nullable=false)
    protected String nome;
    
    @Column(name="partito", nullable=false)
    protected String partito;
    
    @Type( type = "string-array" )
    @Column(
        name = "circoscrizione", 
        columnDefinition = "text[]"
    )
    private String[] circoscrizione;
   // private List<String> circoscrizione;
    
   /*
	public PK() {
		super();
		// TODO Auto-generated constructor stub
	}
	public PK(String nome, String partito, String[] circoscrizione) {
		super();
		this.nome = nome;
		this.partito = partito;
		this.circoscrizione = circoscrizione;
	}
	*/
	public PK getpk() {
		return this;
	}
	public void setpk(String nome, String partito, String[] circoscrizione) {
		this.nome = nome;
		this.partito = partito;
		this.circoscrizione = circoscrizione;
	}


	/**
	 * @return the nome
	 */
	public String getNome() {
		return nome;
	}

	/**
	 * @param nome the nome to set
	 */
	public void setNome(String nome) {
		this.nome = nome;
	}

	/**
	 * @return the partito
	 */
	public String getPartito() {
		return partito;
	}

	/**
	 * @param partito the partito to set
	 */
	public void setPartito(String partito) {
		this.partito = partito;
	}

	/**
	 * @return the circoscrizione
	 */
	public String[] getCircoscrizione() {
		return circoscrizione;
	}

	/**
	 * @param circoscrizione the circoscrizione to set
	 */
	public void setCircoscrizione(String[] circoscrizione) {
		this.circoscrizione = circoscrizione;
	}
	@Override
	public String toString() {
		return "PK [nome=" + nome + ", partito=" + partito + ", circoscrizione=" + Arrays.toString(circoscrizione)
				+ "]";
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + Arrays.hashCode(circoscrizione);
		result = prime * result + Objects.hash(nome, partito);
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		PK other = (PK) obj;
		return Arrays.equals(circoscrizione, other.circoscrizione) && Objects.equals(nome, other.nome)
				&& Objects.equals(partito, other.partito);
	}
	
	
	
	
	
	
	
}
