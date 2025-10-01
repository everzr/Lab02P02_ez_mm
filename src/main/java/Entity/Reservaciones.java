package Entity;

import java.io.Serializable;
import java.util.Collection;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name = "reservaciones")
@NamedQueries({
    @NamedQuery(name = "Reservaciones.findAll", query = "SELECT r FROM Reservaciones r"),
    @NamedQuery(name = "Reservaciones.findByIDReservacion", query = "SELECT r FROM Reservaciones r WHERE r.iDReservacion = :iDReservacion"),
    @NamedQuery(name = "Reservaciones.findByFechaReservacion", query = "SELECT r FROM Reservaciones r WHERE r.fechaReservacion = :fechaReservacion")
})
public class Reservaciones implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "ID_Reservacion")
    private Integer iDReservacion;

    @Basic(optional = false)
    @Temporal(TemporalType.DATE)
    @Column(name = "Fecha_Reservacion", nullable = false)
    private Date fechaReservacion;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "iDReservacion")
    private Collection<DetalleReservacion> detalleReservacionCollection;

    @JoinColumn(name = "ID_Pasajero", referencedColumnName = "ID_Pasajero")
    @ManyToOne(optional = false)
    private Pasajeros iDPasajero;

    public Reservaciones() {}
    public Reservaciones(Integer iDReservacion) { this.iDReservacion = iDReservacion; }
    public Reservaciones(Integer iDReservacion, Date fechaReservacion) { this.iDReservacion = iDReservacion; this.fechaReservacion = fechaReservacion; }

    public Integer getIDReservacion() { return iDReservacion; }
    public void setIDReservacion(Integer iDReservacion) { this.iDReservacion = iDReservacion; }
    public Date getFechaReservacion() { return fechaReservacion; }
    public void setFechaReservacion(Date fechaReservacion) { this.fechaReservacion = fechaReservacion; }
    public Collection<DetalleReservacion> getDetalleReservacionCollection() { return detalleReservacionCollection; }
    public void setDetalleReservacionCollection(Collection<DetalleReservacion> detalleReservacionCollection) { this.detalleReservacionCollection = detalleReservacionCollection; }
    public Pasajeros getIDPasajero() { return iDPasajero; }
    public void setIDPasajero(Pasajeros iDPasajero) { this.iDPasajero = iDPasajero; }

    @Override public int hashCode() { int hash = 0; hash += (iDReservacion != null ? iDReservacion.hashCode() : 0); return hash; }
    @Override public boolean equals(Object object) { if (!(object instanceof Reservaciones)) return false; Reservaciones other = (Reservaciones) object; if ((this.iDReservacion == null && other.iDReservacion != null) || (this.iDReservacion != null && !this.iDReservacion.equals(other.iDReservacion))) return false; return true; }
    @Override public String toString() { return "Entity.Reservaciones[ iDReservacion=" + iDReservacion + " ]"; }
}
