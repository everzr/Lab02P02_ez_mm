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
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name = "vuelos")
@NamedQueries({
    @NamedQuery(name = "Vuelos.findAll", query = "SELECT v FROM Vuelos v"),
    @NamedQuery(name = "Vuelos.findByIDVuelo", query = "SELECT v FROM Vuelos v WHERE v.iDVuelo = :iDVuelo"),
    @NamedQuery(name = "Vuelos.findByNumeroVuelo", query = "SELECT v FROM Vuelos v WHERE v.numeroVuelo = :numeroVuelo"),
    @NamedQuery(name = "Vuelos.findByAerolinea", query = "SELECT v FROM Vuelos v WHERE v.aerolinea = :aerolinea"),
    @NamedQuery(name = "Vuelos.findByOrigen", query = "SELECT v FROM Vuelos v WHERE v.origen = :origen"),
    @NamedQuery(name = "Vuelos.findByDestino", query = "SELECT v FROM Vuelos v WHERE v.destino = :destino"),
    @NamedQuery(name = "Vuelos.findByFechaSalida", query = "SELECT v FROM Vuelos v WHERE v.fechaSalida = :fechaSalida"),
    @NamedQuery(name = "Vuelos.findByHoraSalida", query = "SELECT v FROM Vuelos v WHERE v.horaSalida = :horaSalida"),
    @NamedQuery(name = "Vuelos.findByFechaLlegada", query = "SELECT v FROM Vuelos v WHERE v.fechaLlegada = :fechaLlegada"),
    @NamedQuery(name = "Vuelos.findByHoraLlegada", query = "SELECT v FROM Vuelos v WHERE v.horaLlegada = :horaLlegada"),
    @NamedQuery(name = "Vuelos.findByAvion", query = "SELECT v FROM Vuelos v WHERE v.avion = :avion")
})
public class Vuelos implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "ID_Vuelo")
    private Integer iDVuelo;

    @Basic(optional = false)
    @Column(name = "Numero_Vuelo", length = 20, nullable = false)
    private String numeroVuelo;

    @Basic(optional = false)
    @Column(name = "Aerolinea", length = 100, nullable = false)
    private String aerolinea;

    @Basic(optional = false)
    @Column(name = "Origen", length = 100, nullable = false)
    private String origen;

    @Basic(optional = false)
    @Column(name = "Destino", length = 100, nullable = false)
    private String destino;

    @Basic(optional = false)
    @Temporal(TemporalType.DATE)
    @Column(name = "Fecha_Salida", nullable = false)
    private Date fechaSalida;

    @Basic(optional = false)
    @Temporal(TemporalType.TIME)
    @Column(name = "Hora_Salida", nullable = false)
    private Date horaSalida;

    @Basic(optional = false)
    @Temporal(TemporalType.DATE)
    @Column(name = "Fecha_Llegada", nullable = false)
    private Date fechaLlegada;

    @Basic(optional = false)
    @Temporal(TemporalType.TIME)
    @Column(name = "Hora_Llegada", nullable = false)
    private Date horaLlegada;

    @Column(name = "Avion", length = 100)
    private String avion;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "iDVuelo")
    private Collection<DetalleReservacion> detalleReservacionCollection;

    public Vuelos() {}

    public Vuelos(Integer iDVuelo) { this.iDVuelo = iDVuelo; }

    public Vuelos(Integer iDVuelo, String numeroVuelo, String aerolinea, String origen, String destino, Date fechaSalida, Date horaSalida, Date fechaLlegada, Date horaLlegada) {
        this.iDVuelo = iDVuelo;
        this.numeroVuelo = numeroVuelo;
        this.aerolinea = aerolinea;
        this.origen = origen;
        this.destino = destino;
        this.fechaSalida = fechaSalida;
        this.horaSalida = horaSalida;
        this.fechaLlegada = fechaLlegada;
        this.horaLlegada = horaLlegada;
    }

    public Integer getIDVuelo() { return iDVuelo; }
    public void setIDVuelo(Integer iDVuelo) { this.iDVuelo = iDVuelo; }
    public String getNumeroVuelo() { return numeroVuelo; }
    public void setNumeroVuelo(String numeroVuelo) { this.numeroVuelo = numeroVuelo; }
    public String getAerolinea() { return aerolinea; }
    public void setAerolinea(String aerolinea) { this.aerolinea = aerolinea; }
    public String getOrigen() { return origen; }
    public void setOrigen(String origen) { this.origen = origen; }
    public String getDestino() { return destino; }
    public void setDestino(String destino) { this.destino = destino; }
    public Date getFechaSalida() { return fechaSalida; }
    public void setFechaSalida(Date fechaSalida) { this.fechaSalida = fechaSalida; }
    public Date getHoraSalida() { return horaSalida; }
    public void setHoraSalida(Date horaSalida) { this.horaSalida = horaSalida; }
    public Date getFechaLlegada() { return fechaLlegada; }
    public void setFechaLlegada(Date fechaLlegada) { this.fechaLlegada = fechaLlegada; }
    public Date getHoraLlegada() { return horaLlegada; }
    public void setHoraLlegada(Date horaLlegada) { this.horaLlegada = horaLlegada; }
    public String getAvion() { return avion; }
    public void setAvion(String avion) { this.avion = avion; }
    
    public Collection<DetalleReservacion> getDetalleReservacionCollection() { return detalleReservacionCollection; }
    public void setDetalleReservacionCollection(Collection<DetalleReservacion> detalleReservacionCollection) { this.detalleReservacionCollection = detalleReservacionCollection; }

    @Override public int hashCode() { int hash = 0; hash += (iDVuelo != null ? iDVuelo.hashCode() : 0); return hash; }
    @Override public boolean equals(Object object) { if (!(object instanceof Vuelos)) return false; Vuelos other = (Vuelos) object; if ((this.iDVuelo == null && other.iDVuelo != null) || (this.iDVuelo != null && !this.iDVuelo.equals(other.iDVuelo))) return false; return true; }
    @Override public String toString() { return "Entity.Vuelos[ iDVuelo=" + iDVuelo + " ]"; }
}
