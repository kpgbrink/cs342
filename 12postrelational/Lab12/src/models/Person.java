package models;

import javax.persistence.*;
import java.sql.Time;

/**
 * Created by kpb23 on 5/5/2017.
 */
@Entity
@Table(name = "PERSON", schema = "CPDB", catalog = "")
public class Person {
    private long id;
    private String title;
    private String firstname;
    private String lastname;
    private String membershipstatus;
    private String gender;
    private Time birthdate;
    private String householdrole;
    private String homegrouprole;
    
    /*
     * ManyToOne — Add a new field of type Household to the 
     * Person entity class, add the accessor methods (getName() 
     * & setName()) and annotate its get accessor as follows.
     */
    @ManyToOne
    @JoinColumn(name = "householdid", referencedColumnName = "id")
    private Household household;

    public Household getHousehold() { return household; }
    public void setHousehold(Household new_household) { this.household = new_household; }
    
    /*
     * ManyToMany — Add a new list of Team entities to the 
     * Person entity class, add the accessor methods for this 
     * list attribute and annotate its get accessor as follows.
     */  
     
    @ManyToMany
    @JoinTable(name = "PERSONTEAM", schema = "CPDB",
                joinColumns = @JoinColumn(name = "PERSONID", referencedColumnName = "ID", nullable = false),
                inverseJoinColumns = @JoinColumn(name = "TEAMNAME", referencedColumnName = "NAME", nullable = false))
    private List<Team> teams;
    
    public List<Team> getTeamList() { return teams; }
    public void setTeamList(List<Team> new_teamList) { this.teams = new_teamList; }

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
    @Column(name = "FIRSTNAME")
    public String getFirstname() {
        return firstname;
    }

    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }

    @Basic
    @Column(name = "LASTNAME")
    public String getLastname() {
        return lastname;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
    }

    @Basic
    @Column(name = "MEMBERSHIPSTATUS")
    public String getMembershipstatus() {
        return membershipstatus;
    }

    public void setMembershipstatus(String membershipstatus) {
        this.membershipstatus = membershipstatus;
    }

    @Basic
    @Column(name = "GENDER")
    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    @Basic
    @Column(name = "BIRTHDATE")
    public Time getBirthdate() {
        return birthdate;
    }

    public void setBirthdate(Time birthdate) {
        this.birthdate = birthdate;
    }

    @Basic
    @Column(name = "HOUSEHOLDROLE")
    public String getHouseholdrole() {
        return householdrole;
    }

    public void setHouseholdrole(String householdrole) {
        this.householdrole = householdrole;
    }

    @Basic
    @Column(name = "HOMEGROUPROLE")
    public String getHomegrouprole() {
        return homegrouprole;
    }

    public void setHomegrouprole(String homegrouprole) {
        this.homegrouprole = homegrouprole;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Person that = (Person) o;

        if (id != that.id) return false;
        if (title != null ? !title.equals(that.title) : that.title != null) return false;
        if (firstname != null ? !firstname.equals(that.firstname) : that.firstname != null) return false;
        if (lastname != null ? !lastname.equals(that.lastname) : that.lastname != null) return false;
        if (membershipstatus != null ? !membershipstatus.equals(that.membershipstatus) : that.membershipstatus != null)
            return false;
        if (gender != null ? !gender.equals(that.gender) : that.gender != null) return false;
        if (birthdate != null ? !birthdate.equals(that.birthdate) : that.birthdate != null) return false;
        if (householdrole != null ? !householdrole.equals(that.householdrole) : that.householdrole != null)
            return false;
        if (homegrouprole != null ? !homegrouprole.equals(that.homegrouprole) : that.homegrouprole != null)
            return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) (id ^ (id >>> 32));
        result = 31 * result + (title != null ? title.hashCode() : 0);
        result = 31 * result + (firstname != null ? firstname.hashCode() : 0);
        result = 31 * result + (lastname != null ? lastname.hashCode() : 0);
        result = 31 * result + (membershipstatus != null ? membershipstatus.hashCode() : 0);
        result = 31 * result + (gender != null ? gender.hashCode() : 0);
        result = 31 * result + (birthdate != null ? birthdate.hashCode() : 0);
        result = 31 * result + (householdrole != null ? householdrole.hashCode() : 0);
        result = 31 * result + (homegrouprole != null ? homegrouprole.hashCode() : 0);
        return result;
    }
}
