package Entity;

import java.io.Serializable;
import java.util.Collection;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "Pasajeros")
@NamedQueries({
    @NamedQuery(name = "Pasajeros.findAll", query = "SELECT p FROM Pasajeros p"),
    @NamedQuery(name = "Pasajeros.findByIDPasajero", query = "SELECT p FROM Pasajeros p WHERE p.iDPasajero = :iDPasajero"),
    @NamedQuery(name = "Pasajeros.findByNombrePasajero", query = "SELECT p FROM Pasajeros p WHERE p.nombrePasajero = :nombrePasajero"),
    @NamedQuery(name = "Pasajeros.findByNacionalidad", query = "SELECT p FROM Pasajeros p WHERE p.nacionalidad = :nacionalidad"),
    @NamedQuery(name = "Pasajeros.findByPasaporte", query = "SELECT p FROM Pasajeros p WHERE p.pasaporte = :pasaporte")
})
public class Pasajeros implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "ID_Pasajero")
    private Integer iDPasajero;

    @Basic(optional = false)
    @Column(name = "Nombre_Pasajero", length = 100, nullable = false)
    private String nombrePasajero;

    @Column(name = "Nacionalidad", length = 50)
    private String nacionalidad;

    @Column(name = "Pasaporte", length = 50)
    private String pasaporte;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "iDPasajero")
    private Collection<Reservaciones> reservacionesCollection;

    public Pasajeros() {}
    public Pasajeros(Integer iDPasajero) { this.iDPasajero = iDPasajero; }
    public Pasajeros(Integer iDPasajero, String nombrePasajero) { this.iDPasajero = iDPasajero; this.nombrePasajero = nombrePasajero; }

    public Integer getIDPasajero() { return iDPasajero; }
    public void setIDPasajero(Integer iDPasajero) { this.iDPasajero = iDPasajero; }
    public String getNombrePasajero() { return nombrePasajero; }
    public void setNombrePasajero(String nombrePasajero) { this.nombrePasajero = nombrePasajero; }
    public String getNacionalidad() { return nacionalidad; }
    public void setNacionalidad(String nacionalidad) { this.nacionalidad = nacionalidad; }
    public String getPasaporte() { return pasaporte; }
    public void setPasaporte(String pasaporte) { this.pasaporte = pasaporte; }
    public Collection<Reservaciones> getReservacionesCollection() { return reservacionesCollection; }
    public void setReservacionesCollection(Collection<Reservaciones> reservacionesCollection) { this.reservacionesCollection = reservacionesCollection; }

    @Override public int hashCode() { int hash = 0; hash += (iDPasajero != null ? iDPasajero.hashCode() : 0); return hash; }
    @Override public boolean equals(Object object) { if (!(object instanceof Pasajeros)) return false; Pasajeros other = (Pasajeros) object; if ((this.iDPasajero == null && other.iDPasajero != null) || (this.iDPasajero != null && !this.iDPasajero.equals(other.iDPasajero))) return false; return true; }
    @Override public String toString() { return "Entity.Pasajeros[ iDPasajero=" + iDPasajero + " ]"; }
}
