package models;

import javax.persistence.*;

/**
 * Created by kpb23 on 5/12/2017.
 */
@Entity
@Table(name = "PLACEANDHOURS", schema = "KPB23", catalog = "")
public class PlaceandhoursEntity {
    private long id;
    private String placeName;
    private String hourScript;

    @Id
    @Column(name = "ID")
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    @Basic
    @Column(name = "PLACE_NAME")
    public String getPlaceName() {
        return placeName;
    }

    public void setPlaceName(String placeName) {
        this.placeName = placeName;
    }

    @Basic
    @Column(name = "HOUR_SCRIPT")
    public String getHourScript() {
        return hourScript;
    }

    public void setHourScript(String hourScript) {
        this.hourScript = hourScript;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        PlaceandhoursEntity that = (PlaceandhoursEntity) o;

        if (id != that.id) return false;
        if (placeName != null ? !placeName.equals(that.placeName) : that.placeName != null) return false;
        if (hourScript != null ? !hourScript.equals(that.hourScript) : that.hourScript != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (id ^ (id >>> 32));
        result = 31 * result + (placeName != null ? placeName.hashCode() : 0);
        result = 31 * result + (hourScript != null ? hourScript.hashCode() : 0);
        return result;
    }
}
