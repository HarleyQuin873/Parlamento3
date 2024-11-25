package com.giuggiola.entity;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import org.springframework.stereotype.Component;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Component
@Data
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode
@Embeddable
public class Range2PK implements Serializable{
	
	private static final long serialVersionUID = 1;

	@Column(name="nome", nullable=false)
	protected String nome;
	
	@Column(name = "mandato_commissione", nullable=false)
	protected String mandato_commissione;

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getMandato_commissione() {
		return mandato_commissione;
	}

	public void setMandato_commissione(String mandato_commissione) {
		this.mandato_commissione = mandato_commissione;
	}

	@Override
	public String toString() {
		return "nome=" + nome + ", mandato_commissione=" + mandato_commissione;
	}

	@Override
	public int hashCode() {
		return Objects.hash(mandato_commissione, nome);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Range2PK other = (Range2PK) obj;
		return Objects.equals(mandato_commissione, other.mandato_commissione) && Objects.equals(nome, other.nome);
	}
	
	
	
}
