<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST, GET, PUT, DELETE");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

include_once '../config/database.php';//importing previous files into this one file
include_once '../models/petitions.php';

$database = new Database();
$db = $database->getConnection();

$petitions = new petitions($db);

$request_method = $_SERVER["REQUEST_METHOD"];

switch($request_method) {
    case 'GET':
        $stmt = $petitions->read();
        $num = $stmt->rowCount();

        if($num > 0) {
            $petitions_arr = array();
            $petitions_arr["records"] = array();

            while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                extract($row);

                $petitions_item = array(
                    "id" => $id,
                    "type" => $type,
                    "date"=>$date,
                    "title" => $title,
                    "sender" => $sender,
                    "description"=>$description,
                    "receiver" => $receiver,
                    "status" => $status,
                    "tracking" => $tracking
                
                );

                array_push($petitions_arr["records"], $petitions_item);
            }

            http_response_code(200);
            echo json_encode($petitions_arr);
        } else {
            http_response_code(404);
            echo json_encode(array("message" => "No Petition found."));
        }
        break;

    case 'POST':
        $data = json_decode(file_get_contents("php://input"));

        if (
            !empty($data->type) &&
            !empty($data->date) &&
            !empty($data->title) &&
            !empty($data->sender) &&
            !empty($data->description) &&
            
            !empty($data->receiver)&&
            !empty($data->status)&&
            !empty($data->tracking)
            
        ) {
            $petitions->type = $data->type;
            $petitions->date = $data->date;
           
            $petitions->title = $data->title;
            $petitions->sender = $data->sender;
            $petitions->description = $data->description;
            
            $petitions->receiver = $data->receiver;
            $petitions->status = $data->status;
            $petitions->tracking = $data->tracking;

            if ($petitions->create()) {
                http_response_code(201);
                echo json_encode(array("message" => "Petition has been added in Database."));
            } else {
                http_response_code(503);
                echo json_encode(array("message" => "Unable to create petition."));
            }
        } else {
            http_response_code(400);
            echo json_encode(array("message" => "Unable to create Petition. Data is not complete."));
        }
        break;

    case 'PUT':
        $data = json_decode(file_get_contents("php://input"));

        $petitions->id = $data->id;

        if (
            !empty($data->type) &&
            !empty($data->date) &&
           
            !empty($data->title) &&
            !empty($data->sender) &&
            !empty($data->description) &&
           
            !empty($data->receiver)&&
            !empty($data->status)&&
            !empty($data->tracking)
            
        ) {
            $petitions->type = $data->type;
            $petitions->date = $data->date;
           
            $petitions->title = $data->title;
            $petitions->sender = $data->sender;
            $petitions->description = $data->description;
           
            $petitions->receiver = $data->receiver;
            $petitions->status = $data->status;
            $petitions->tracking = $data->tracking;


            if ($petitions->update()) {
                http_response_code(200);
                echo json_encode(array("message" => "Petition has been updated."));
            } else {
                http_response_code(503);
                echo json_encode(array("message" => "Unable to update Petiton."));
            }
        } else {
            http_response_code(400);
            echo json_encode(array("message" => "Unable to update Petition. Data is incomplete."));
        }
        break;

    case 'DELETE':
        $data = json_decode(file_get_contents("php://input"));

        $petitions->id = $data->id;

        if ($petitions->delete()) {
            http_response_code(200);
            echo json_encode(array("message" => "Petition is deleted successfully."));
        } else {
            http_response_code(503);
            echo json_encode(array("message" => "Unable to delete petition some error occured."));
        }
        break;

    default:
        http_response_code(405);
        echo json_encode(array("message" => "Method not allowed."));
        break;
}
?>
