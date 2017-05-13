import models.*;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.print.attribute.standard.Media;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import java.util.List;


/**
 * Created by kpb23 on 5/12/2017.
 */
@Stateless
@Path("scheduleMaker")
public class Schedule {
    @PersistenceContext
    private EntityManager em;


    /********* GET ***********************/

    @GET
    @Path("hello")
    @Produces("text/plain")
    public String getIntroductionMessage() {
        return "Schedule databse";
    }

    // Get Student from database
    @GET
    @Path("student/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public StudentEntity getStudent(@PathParam("id") long id) {
        return em.find(StudentEntity.class, id);
    }

    // Get all Students from database
    @GET
    @Path("student")
    @Produces(MediaType.APPLICATION_JSON)
    public List<StudentEntity> getStudents() {
        return em.createQuery(em.getCriteriaBuilder().createQuery(StudentEntity.class)).getResultList();
    }

    // Get Schedule from database
    @GET
    @Path("schedule/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public ScheduleEntity getSchedule(@PathParam("id") long id) {
        return em.find(ScheduleEntity.class, id);
    }

    // Get all Schedules from database
    @GET
    @Path("schedule")
    @Produces(MediaType.APPLICATION_JSON)
    public List<ScheduleEntity> getSchedules() {
        return em.createQuery(em.getCriteriaBuilder().createQuery(ScheduleEntity.class)).getResultList();
    }

    // Get FriendGroup from database
    @GET
    @Path("friendgroup/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public FriendgroupEntity getFriendGroup(@PathParam("id") long id) {
        return em.find(FriendgroupEntity.class, id);
    }

    // Get all FriendGroup from database
    @GET
    @Path("friendgroup")
    @Produces(MediaType.APPLICATION_JSON)
    public List<FriendgroupEntity> getFriendGroup() {
        return em.createQuery(em.getCriteriaBuilder().createQuery(FriendgroupEntity.class)).getResultList();
    }

    // Get ClassLink from database
    @GET
    @Path("classlink/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public ClasslinkEntity getClassLink(@PathParam("id") long id) {
        return em.find(ClasslinkEntity.class, id);
    }

    // Get all ClassLinks from database
    @GET
    @Path("classlink")
    @Produces(MediaType.APPLICATION_JSON)
    public List<ClasslinkEntity> getClassLinks() {
        return em.createQuery(em.getCriteriaBuilder().createQuery(ClasslinkEntity.class)).getResultList();
    }

    // Get Sidebarlink from database
    @GET
    @Path("sidebarlink/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public SidebarlinkEntity getSideBar(@PathParam("id") long id) {
        return em.find(SidebarlinkEntity.class, id);
    }

    // Get all Sidebarlink from database
    @GET
    @Path("sidebarlink")
    @Produces(MediaType.APPLICATION_JSON)
    public List<SidebarlinkEntity> getSideBarLinks() {
        return em.createQuery(em.getCriteriaBuilder().createQuery(SidebarlinkEntity.class)).getResultList();
    }

    /************************* Post ***********************************/
    // Add new student to database
    @POST
    @Path("student")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public StudentEntity postStudent(StudentEntity student) {
        StudentEntity newStudent = new StudentEntity();
        newStudent.setId(student.getId());
        newStudent.setEmail(student.getEmail());
        newStudent.setFirstname(student.getFirstname());
        newStudent.setMiddlename(student.getMiddlename());
        newStudent.setLastname(student.getLastname());
        return newStudent;
    };

    // Add new schedule to database
    @POST
    @Path("schedule")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public ScheduleEntity postSchedule(ScheduleEntity schedule) {
        ScheduleEntity newSchedule = new ScheduleEntity();
        newSchedule.setId(schedule.getId());
        newSchedule.setLink(schedule.getLink());
        newSchedule.setPermission(schedule.getPermission());
        newSchedule.setSemester(schedule.getSemester());
        newSchedule.setTitle(schedule.getTitle());
        newSchedule.setSemesterYear(schedule.getSemesterYear());
        return newSchedule;
    };

    /************ PUT *************************/
    // Make a new student
    @PUT
    @Path("student/{id}")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public StudentEntity putStudent(@PathParam("id") long id, StudentEntity student) {
        StudentEntity overRideStudent = em.find(StudentEntity.class, id);
        if ( overRideStudent != null) {
            em.merge(student);
        }
        return student;
    }

    /************************ DELETE *******************/
    // Delete a student
    @DELETE
    @Path("student/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public String deleteStudent(@PathParam("id") long id) {
        StudentEntity student = em.find(StudentEntity.class, id);
        if (student != null) {
            em.remove(student);
        } else {
            return "student not found";
        }
        return "deleted student";
    }
}
