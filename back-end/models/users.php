<?php
class Users {
    private $conn;
    private $table_name = "users";

    public $id;
    public $name;
    public $email;
    public $password;
    public $university_id;
    public $created_at;
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

    public function create() { //creating a new user for university adming
        $query = "INSERT INTO " . $this->table_name . " SET name=:name,email=:email ,password=:password, university_id=:university_id,created_at=:created_at, role=:role";
        $stmt = $this->conn->prepare($query);

        $this->name = htmlspecialchars(strip_tags($this->name));
        $this->email = htmlspecialchars(strip_tags($this->email));
        $this->password = htmlspecialchars(strip_tags($this->password));
        $this->university_id = htmlspecialchars(strip_tags($this->university_id));
        $this->created_at = htmlspecialchars(strip_tags($this->created_at));
        $this->role = htmlspecialchars(strip_tags($this->role));

        $stmt->bindParam(":name", $this->name);
        $stmt->bindParam(":email", $this->email);
        $stmt->bindParam(":password", $this->password);
        $stmt->bindParam(":university_id", $this->university_id);
        $stmt->bindParam(":created_at", $this->created_at);
        $stmt->bindParam(":role", $this->role);
      
        if($stmt->execute()) {
            return true;
        }

        return false;
    }

    public function update() {//updating the user 
        $query = "UPDATE " . $this->table_name . " SET name = :name,email=:email, password = :password, university_id = :university_id,created_at=:created_at ,role = :role WHERE id = :id";
        $stmt = $this->conn->prepare($query);

        $this->name = htmlspecialchars(strip_tags($this->name));
        $this->email = htmlspecialchars(strip_tags($this->email));
        $this->password = htmlspecialchars(strip_tags($this->password));
        $this->university_id = htmlspecialchars(strip_tags($this->university_id));
        $this->created_at = htmlspecialchars(strip_tags($this->created_at));
        $this->role = htmlspecialchars(strip_tags($this->role));
        

        $stmt->bindParam(':name', $this->name);
        $stmt->bindParam(":email", $this->email);
        $stmt->bindParam(':password', $this->password);
        $stmt->bindParam(':university_id', $this->university_id);
        $stmt->bindParam(':created_at', $this->created_at);
        $stmt->bindParam(":role", $this->role);       
      
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
