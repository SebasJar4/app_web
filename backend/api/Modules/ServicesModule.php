<?php

namespace Modules;

class ServicesModule extends BaseModule {
    // Agregar un nuevo servicio
    public function addService ($service_name, $service_description, $imgs_id, $service_descuento, $state_objets_id)
    {
        $query = "CALL add_service(?, ?, ?, ?, ?)";
        $params = [$service_name, $service_description, $imgs_id, $service_descuento, $state_objets_id];
        return $this->executeQuery($query, $params);
    }

    // Obtener servicio por ID
    public function getServiceById($service_id)
    {
        $query = "CALL get_service_by_id(?)";
        return $this->getSingleRow($query, [$service_id]);
    }

    // Obtener servicios activos
    public function getActiveServices()
    {
        $query = "CALL get_services_active()";
        return $this->getAllRows($query);
    }

    // Obtener servicios por estado ('all' o un número)
    public function getServicesByState($state)
    {
        $query = "CALL get_state_services(?)";
        return $this->getAllRows($query, [$state]);
    }

    // Obtener servicios por rango de descuento (solo activos)
    public function getServicesByDiscountRange($min, $max)
    {
        $query = "CALL get_services_by_discount_range(?, ?)";
        return $this->getAllRows($query, [$min, $max]);
    }

    // Obtener servicio activo por ID
    public function getActiveServiceById($service_id)
    {
        $query = "CALL get_active_service_by_id(?)";
        return $this->getSingleRow($query, [$service_id]);
    }

    // Actualizar un servicio
    public function updateService($service_id, $service_name, $service_description, $imgs_id, $service_descuento, $state_objets_id)
    {
        $query = "CALL update_service(?, ?, ?, ?, ?, ?)";
        $params = [$service_id, $service_name, $service_description, $imgs_id, $service_descuento, $state_objets_id];
        return $this->executeQuery($query, $params);
    }

    // Desactivar un servicio (eliminación lógica)
    public function deactivateService($service_id, $maker_user_id)
    {
        $query = "CALL deactivate_service(?, ?)";
        return $this->executeQuery($query, [$service_id, $maker_user_id]);
    }
}
