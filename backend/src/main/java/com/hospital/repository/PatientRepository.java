package com.hospital.repository;

import com.hospital.model.Patient;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface PatientRepository extends JpaRepository<Patient, Long> {
    
    List<Patient> findByNomContainingIgnoreCaseOrPrenomContainingIgnoreCase(String nom, String prenom);
    
    @Query("SELECT p FROM Patient p WHERE " +
           "LOWER(p.nom) LIKE LOWER(CONCAT('%', :query, '%')) OR " +
           "LOWER(p.prenom) LIKE LOWER(CONCAT('%', :query, '%')) OR " +
           "p.numeroSecuriteSociale LIKE CONCAT('%', :query, '%')")
    List<Patient> searchPatients(@Param("query") String query);
}
