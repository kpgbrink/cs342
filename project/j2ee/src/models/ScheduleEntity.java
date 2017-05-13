package models;

import javax.persistence.*;

/**
 * Created by kpb23 on 5/12/2017.
 */
@Entity
@Table(name = "SCHEDULE", schema = "KPB23", catalog = "")
public class ScheduleEntity {
    private long id;
    private String title;
    private String semester;
    private Long semesterYear;
    private String link;
    private String permission;

    @Id
    @Column(name = "ID")
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    @Basic
    @Column(name = "TITLE")
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    @Basic
    @Column(name = "SEMESTER")
    public String getSemester() {
        return semester;
    }

    public void setSemester(String semester) {
        this.semester = semester;
    }

    @Basic
    @Column(name = "SEMESTER_YEAR")
    public Long getSemesterYear() {
        return semesterYear;
    }

    public void setSemesterYear(Long semesterYear) {
        this.semesterYear = semesterYear;
    }

    @Basic
    @Column(name = "LINK")
    public String getLink() {
        return link;
    }

    public void setLink(String link) {
        this.link = link;
    }

    @Basic
    @Column(name = "PERMISSION")
    public String getPermission() {
        return permission;
    }

    public void setPermission(String permission) {
        this.permission = permission;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        ScheduleEntity that = (ScheduleEntity) o;

        if (id != that.id) return false;
        if (title != null ? !title.equals(that.title) : that.title != null) return false;
        if (semester != null ? !semester.equals(that.semester) : that.semester != null) return false;
        if (semesterYear != null ? !semesterYear.equals(that.semesterYear) : that.semesterYear != null) return false;
        if (link != null ? !link.equals(that.link) : that.link != null) return false;
        if (permission != null ? !permission.equals(that.permission) : that.permission != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (id ^ (id >>> 32));
        result = 31 * result + (title != null ? title.hashCode() : 0);
        result = 31 * result + (semester != null ? semester.hashCode() : 0);
        result = 31 * result + (semesterYear != null ? semesterYear.hashCode() : 0);
        result = 31 * result + (link != null ? link.hashCode() : 0);
        result = 31 * result + (permission != null ? permission.hashCode() : 0);
        return result;
    }
}
