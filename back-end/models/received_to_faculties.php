<?php
class received_to_faculties {
    private $conn;
    private $table_name = "received_to_faculties";

    public $id;
    public $petition_id;
    public $faculty_id;
    public $comment;
    

    public function __construct($db) {//constructor
        $this->conn = $db;
    }

    public function read() {
        $query = "SELECT * FROM " . $this->table_name;
        $stmt = $this->conn->prepare($query);
        $stmt->execute();

        return $stmt;
    }

    public function create() { //creating a new user for university adming
        $query = "INSERT INTO " . $this->table_name . " SET petition_id=:petition_id,faculty_id=:faculty_id ,comment=:comment";
        $stmt = $this->conn->prepare($query);

        $this->petition_id = htmlspecialchars(strip_tags($this->petition_id));
        $this->faculty_id = htmlspecialchars(strip_tags($this->faculty_id));
        $this->comment = htmlspecialchars(strip_tags($this->comment));

        $stmt->bindParam(":petition_id", $this->petition_id);
        $stmt->bindParam(":faculty_id", $this->faculty_id);
        $stmt->bindParam(":comment", $this->comment);
        
        if($stmt->execute()) {
            return true;
        }

        return false;
    }

    public function update() {//updating the user 
        $query = "UPDATE " . $this->table_name . " SET petition_id = :petition_id,faculty_id=:faculty_id,
         comment = :comment";
        $stmt = $this->conn->prepare($query);

        $this->petition_id = htmlspecialchars(strip_tags($this->petition_id));
        $this->faculty_id = htmlspecialchars(strip_tags($this->faculty_id));
        $this->comment = htmlspecialchars(strip_tags($this->comment));
        

        $stmt->bindParam(':petition_id', $this->petition_id);
        $stmt->bindParam(":faculty_id", $this->faculty_id);
        $stmt->bindParam(':comment', $this->comment);
      
        if ($stmt->execute()) {
            return true;
        }

        return false;
    }

    public function delete() { //deleting the user from database
        $query = "DELETE FROM " . $this->table_name . " WHERE id = :id";
        $stmt = $this->conn->prepare($query);

        $this->id = htmlspecialchars(strip_tags($this->id));
        $stmt->bindParam(':id', $this->id);

        if ($stmt->execute()) {
            return true;
        }

        return false;
    }
}
?>
