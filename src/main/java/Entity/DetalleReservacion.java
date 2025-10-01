package Entity;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name = "Detalle_Reservacion")
@NamedQueries({
    @NamedQuery(name = "DetalleReservacion.findAll", query = "SELECT d FROM DetalleReservacion d"),
    @NamedQuery(name = "DetalleReservacion.findByIDDetalle", query = "SELECT d FROM DetalleReservacion d WHERE d.iDDetalle = :iDDetalle"),
    @NamedQuery(name = "DetalleReservacion.findByAsiento", query = "SELECT d FROM DetalleReservacion d WHERE d.asiento = :asiento"),
    @NamedQuery(name = "DetalleReservacion.findByClase", query = "SELECT d FROM DetalleReservacion d WHERE d.clase = :clase")
})
public class DetalleReservacion implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "ID_Detalle")
    private Integer iDDetalle;

    @Column(name = "Asiento", length = 10)
    private String asiento;

    @Column(name = "Clase", length = 9)
    private String clase;

    @JoinColumn(name = "ID_Reservacion", referencedColumnName = "ID_Reservacion")
    @ManyToOne(optional = false)
    private Reservaciones iDReservacion;

    @JoinColumn(name = "ID_Vuelo", referencedColumnName = "ID_Vuelo")
    @ManyToOne(optional = false)
    private Vuelos iDVuelo;

    public DetalleReservacion() {}
    public DetalleReservacion(Integer iDDetalle) { this.iDDetalle = iDDetalle; }

    public Integer getIDDetalle() { return iDDetalle; }
    public void setIDDetalle(Integer iDDetalle) { this.iDDetalle = iDDetalle; }
    public String getAsiento() { return asiento; }
    public void setAsiento(String asiento) { this.asiento = asiento; }
    public String getClase() { return clase; }
    public void setClase(String clase) { this.clase = clase; }
    public Reservaciones getIDReservacion() { return iDReservacion; }
    public void setIDReservacion(Reservaciones iDReservacion) { this.iDReservacion = iDReservacion; }
    public Vuelos getIDVuelo() { return iDVuelo; }
    public void setIDVuelo(Vuelos iDVuelo) { this.iDVuelo = iDVuelo; }

    @Override public int hashCode() { int hash = 0; hash += (iDDetalle != null ? iDDetalle.hashCode() : 0); return hash; }
    @Override public boolean equals(Object object) { if (!(object instanceof DetalleReservacion)) return false; DetalleReservacion other = (DetalleReservacion) object; if ((this.iDDetalle == null && other.iDDetalle != null) || (this.iDDetalle != null && !this.iDDetalle.equals(other.iDDetalle))) return false; return true; }
    @Override public String toString() { return "Entity.DetalleReservacion[ iDDetalle=" + iDDetalle + " ]"; }
}
