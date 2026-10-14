package com.helpdesk.service;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.helpdesk.entity.Incident;
import com.helpdesk.repository.IncidentRepository;

@Service
public class IncidentService {

    private final IncidentRepository incidentRepository;

    public IncidentService(IncidentRepository incidentRepository) {
        this.incidentRepository = incidentRepository;
    }

    public List<Incident> getAllIncidents() {
        return incidentRepository.findAll();
    }

    public Optional<Incident> getIncidentById(Long id) {
        return incidentRepository.findById(id);
    }

    public Incident createIncident(Incident incident) {
        incident.setId(null);
        return incidentRepository.save(incident);
    }

    public Optional<Incident> updateIncident(Long id, Incident updatedIncident) {
        return incidentRepository.findById(id).map(existing -> {
            existing.setTitle(updatedIncident.getTitle());
            existing.setDescription(updatedIncident.getDescription());
            existing.setCategory(updatedIncident.getCategory());
            existing.setPriority(updatedIncident.getPriority());
            existing.setStatus(updatedIncident.getStatus());
            existing.setAssignedTo(updatedIncident.getAssignedTo());

            return incidentRepository.save(existing);
        });
    }

    public boolean deleteIncident(Long id) {
        if (!incidentRepository.existsById(id)) {
            return false;
        }

        incidentRepository.deleteById(id);
        return true;
    }
}