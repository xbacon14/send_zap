package py.com.flextech.dao;

import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;
import jakarta.transaction.Transactional;
import py.com.flextech.models.dto.GenerateTokenResponse;

@ApplicationScoped
public class GenerateTokenResponseDao {

  @Inject
  EntityManager em;

  @Transactional
  public void save(GenerateTokenResponse generateTokenResponse) {
    em.persist(generateTokenResponse);
  }

  @Transactional
  public void deleteBySessionID(String session) {
    String query = "DELETE FROM sys_session  WHERE session LIKE :session";
    Query nativeQuery = em.createNativeQuery(query).setParameter("session", session);
    nativeQuery.getSingleResult();
  }

  public String findTokeBySessionID(String session) {
    String query = "SELECT s.token FROM sys_session s WHERE s.session LIKE :session";
    Query nativeQuery = em.createNativeQuery(query).setParameter("session", session);
    return (String) nativeQuery.getSingleResult();
  }
}
