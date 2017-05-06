package models;

import javax.persistence.*;

/**
 * Created by kpb23 on 5/5/2017.
 */
@Entity
@Table(name = "PERSONTEAM", schema = "CPDB", catalog = "")
@IdClass(PersonteamEntityPK.class)
public class PersonteamEntity {
    private long personid;
    private String teamname;
    private String role;
    private String duration;

    @Id
    @Column(name = "PERSONID")
    public long getPersonid() {
        return personid;
    }

    public void setPersonid(long personid) {
        this.personid = personid;
    }

    @Id
    @Column(name = "TEAMNAME")
    public String getTeamname() {
        return teamname;
    }

    public void setTeamname(String teamname) {
        this.teamname = teamname;
    }

    @Basic
    @Column(name = "ROLE")
    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    @Basic
    @Column(name = "DURATION")
    public String getDuration() {
        return duration;
    }

    public void setDuration(String duration) {
        this.duration = duration;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        PersonteamEntity that = (PersonteamEntity) o;

        if (personid != that.personid) return false;
        if (teamname != null ? !teamname.equals(that.teamname) : that.teamname != null) return false;
        if (role != null ? !role.equals(that.role) : that.role != null) return false;
        if (duration != null ? !duration.equals(that.duration) : that.duration != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (personid ^ (personid >>> 32));
        result = 31 * result + (teamname != null ? teamname.hashCode() : 0);
        result = 31 * result + (role != null ? role.hashCode() : 0);
        result = 31 * result + (duration != null ? duration.hashCode() : 0);
        return result;
    }
}
