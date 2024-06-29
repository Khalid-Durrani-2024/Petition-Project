<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: GET");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

include_once '../config/database.php';//importing previous file of Database connectivity into this one file
include_once '../models/universities.php';

$database = new Database();
$db = $database->getConnection();

$universities = new universities($db);

$request_method = $_SERVER["REQUEST_METHOD"];

switch($request_method) {
    case 'GET':
        $stmt = $universities->read();
        $num = $stmt->rowCount();
        if($num > 0) {
   
            $universities_arr = array();
            $universities_arr["records"] = array();

            while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                extract($row);

                $universities_item = array(
                    "id" => $id,
                    "name" => $name,
                    "location" => $location,
                    "created_at" => $created_at
                );

                array_push($universities_arr["records"], $universities_item);
              
            }

            http_response_code(200);
            echo json_encode($universities_arr);
        } else {
            http_response_code(404);
            echo json_encode(array("message" => "No University found."));
        }
        break;

    case 'POST':
        $data = json_decode(file_get_contents("php://input"));

        if (
            !empty($data->name) &&
            !empty($data->location) &&
            !empty($data->created_at)
        ) {
            $universities->name = $data->name;
            $universities->location = $data->location;
            $universities->created_at = $data->created_at;

            if ($universities->create()) {
                http_response_code(201);
                echo json_encode(array("message" => "University added in Database."));
            } else {
                http_response_code(503);
                echo json_encode(array("message" => "Unable to add university."));
            }
        } else {
            http_response_code(400);
            echo json_encode(array("message" => "Unable to add university in database. Data is incomplete."));
        }
        break;

    case 'PUT':
        $data = json_decode(file_get_contents("php://input"));

        $universities->id = $data->id;

        if (
            !empty($data->name) &&
            !empty($data->location) &&
            !empty($data->created_at)
        ) {
            $universities->name = $data->name;
            $universities->location = $data->location;
            $universities->created_at = $data->created_at;

            if ($universities->update()) {
                http_response_code(200);
                echo json_encode(array("message" => "University has been Updated."));
            } else {
                http_response_code(503);
                echo json_encode(array("message" => "Unable to update University some error occured."));
            }
        } else {
            http_response_code(400);
            echo json_encode(array("message" => "Unable to update Univeristy. Data is incomplete."));
        }
        break;

    case 'DELETE':
        $data = json_decode(file_get_contents("php://input"));

        $universities->id = $data->id;

        if ($universities->delete()) {
            http_response_code(200);
            echo json_encode(array("message" => "University has been deleted."));
        } else {
            http_response_code(503);
            echo json_encode(array("message" => "Unable to delete university."));
        }
        break;

    default:
        http_response_code(405);
        echo json_encode(array("message" => "Method not allowed."));
        break;
}
?>
