<?php
class Petitions {
    private $conn;
    private $table_name = "petitions";

    public $id;
    public $type;
    public $date;
    public $title;
    public $sender;
    public $description;
    public $receiver;
    public $status;
    public $tracking;
    

    public function __construct($db) {//constructor
        $this->conn = $db;
    }

    public function read() {
        $query = "SELECT * FROM " . $this->table_name;
        $stmt = $this->conn->prepare($query);
        $stmt->execute();

        return $stmt;
    }

    public function create() { //creating a petition
        $query = "INSERT INTO " . $this->table_name . " SET type=:type,date=:date ,title=:title, sender=:sender,description=:description, receiver=:receiver,status=:status,tracking=:tracking";
        $stmt = $this->conn->prepare($query);

        $this->type = htmlspecialchars(strip_tags($this->type));
        $this->date = htmlspecialchars(strip_tags($this->date));
        $this->title = htmlspecialchars(strip_tags($this->title));
        $this->sender = htmlspecialchars(strip_tags($this->sender));
        $this->description = htmlspecialchars(strip_tags($this->description));
        $this->receiver = htmlspecialchars(strip_tags($this->receiver));
        $this->status = htmlspecialchars(strip_tags($this->status));
        $this->tracking = htmlspecialchars(strip_tags($this->tracking));

        $stmt->bindParam(":type", $this->type);
        $stmt->bindParam(":date", $this->date);
        $stmt->bindParam(":title", $this->title);
        $stmt->bindParam(":sender", $this->sender);
        $stmt->bindParam(":description", $this->description);
        $stmt->bindParam(":receiver", $this->receiver);
        $stmt->bindParam(":status", $this->status);
        $stmt->bindParam(":tracking", $this->tracking);

        if($stmt->execute()) {
            return true;
        }

        return false;
    }

    public function update() {//updating the petition 
        $query = "UPDATE " . $this->table_name . " SET type = :type,date=:date, title = :title, sender = :sender,description=:description ,receiver = :receiver,status=:status,tracking=:tracking WHERE id = :id";
        $stmt = $this->conn->prepare($query);

        $this->type = htmlspecialchars(strip_tags($this->type));
        $this->date = htmlspecialchars(strip_tags($this->date));
        $this->title = htmlspecialchars(strip_tags($this->title));
        $this->sender = htmlspecialchars(strip_tags($this->sender));
        $this->description = htmlspecialchars(strip_tags($this->description));
        $this->receiver = htmlspecialchars(strip_tags($this->receiver));
        $this->status = htmlspecialchars(strip_tags($this->status));
        $this->tracking = htmlspecialchars(strip_tags($this->tracking));
        

        $stmt->bindParam(':type', $this->type);
        $stmt->bindParam(":date", $this->date);
        $stmt->bindParam(':title', $this->title);
        $stmt->bindParam(':sender', $this->sender);
        $stmt->bindParam(':description', $this->description);
        $stmt->bindParam(":receiver", $this->receiver);       
        $stmt->bindParam(':status', $this->status);
        $stmt->bindParam(':tracking', $this->tracking);

        if ($stmt->execute()) {
            return true;
        }

        return false;
    }

    public function delete() { //deleting the petition
        $query = "DELETE FROM " . $this->table_name . " WHERE id = :id";
        $stmt = $this->conn->prepare($query);

        $this->id = htmlspecialchars(strip_tags($this->id));
        $stmt->bindParam(':id', $this->id);

        if ($stmt->execute()) {
            return true;
        }

        return false;
    }

    public function readBySender($sender) {
        $query = "SELECT * FROM " . $this->table_name . " WHERE sender = :sender";
        $stmt = $this->conn->prepare($query);

        $sender = htmlspecialchars(strip_tags($sender));
        $stmt->bindParam(':sender', $sender);

        $stmt->execute();

        return $stmt;
    }
}
?>
