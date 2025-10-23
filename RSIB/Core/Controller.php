<?php
class Controller {
    public function model($model) {
        require_once __DIR__ . "/../Models/$model.php";
        return new $model;
    }

    public function view($view, $data = []) {
       require_once __DIR__ . "/../Views/$view.php";
    }
}
?>
