<?php
class Faculty {
    private $conn;
    private $table_name = "faculty";

    public $id;
    public $name;
    public $university_id;
    public $email;
    public $password;
    public $university_name;
    public $role;
    

    public function __construct($db) {//constructor
        $this->conn = $db;
    }

    public function read() {
        $query = "SELECT * FROM " . $this->table_name;
        $stmt = $this->conn->prepare($query);
        $stmt->execute();

        return $stmt;
    }

    public function create() { //creating an faculty
        $query = "INSERT INTO " . $this->table_name . " SET name=:name,university_id=:university_id ,email=:email, password=:password,university_name=:university_name, role=:role";
        $stmt = $this->conn->prepare($query);

        $this->name = htmlspecialchars(strip_tags($this->name));
        $this->university_id = htmlspecialchars(strip_tags($this->university_id));
        $this->email = htmlspecialchars(strip_tags($this->email));
        $this->password = htmlspecialchars(strip_tags($this->password));
        $this->university_name = htmlspecialchars(strip_tags($this->university_name));
        $this->role = htmlspecialchars(strip_tags($this->role));

        $stmt->bindParam(":name", $this->name);
        $stmt->bindParam(":university_id", $this->university_id);
        $stmt->bindParam(":email", $this->email);
        $stmt->bindParam(":password", $this->password);
        $stmt->bindParam(":university_name", $this->university_name);
        $stmt->bindParam(":role", $this->role);

        if($stmt->execute()) {
            return true;
        }

        return false;
    }

    public function update() {//updating the faculty 
        $query = "UPDATE " . $this->table_name . " SET name = :name,university_id=:university_id, email = :email, password = :password,university_name=:university_name ,role = :role WHERE id = :id";
        $stmt = $this->conn->prepare($query);

        $this->name = htmlspecialchars(strip_tags($this->name));
        $this->university_id = htmlspecialchars(strip_tags($this->university_id));
        $this->email = htmlspecialchars(strip_tags($this->email));
        $this->password = htmlspecialchars(strip_tags($this->password));
        $this->role = htmlspecialchars(strip_tags($this->role));
        $this->university_name = htmlspecialchars(strip_tags($this->university_name));
        $this->id = htmlspecialchars(strip_tags($this->id));

        $stmt->bindParam(':name', $this->name);
        $stmt->bindParam(":university_id", $this->university_id);
        $stmt->bindParam(':email', $this->email);
        $stmt->bindParam(':password', $this->password);
        $stmt->bindParam(':role', $this->role);
        $stmt->bindParam(":university_name", $this->university_name);       
        $stmt->bindParam(':id', $this->id);

        if ($stmt->execute()) {
            return true;
        }

        return false;
    }

    public function delete() { //deleting the faculty recored
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
