<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: GET,POST,PUT,DELETE");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");


include_once '../config/database.php';//importing previous file of Database connectivity into this one file
include_once '../models/signatures.php';



$database = new Database();
$db = $database->getConnection();

$signatures = new signatures($db);

$request_method = $_SERVER["REQUEST_METHOD"];

switch($request_method) {
    case 'GET':
        $stmt = $signatures->read();
        $num = $stmt->rowCount();
        if($num > 0) {
   
            $signatures_arr = array();
            $signatures_arr["records"] = array();

            while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                extract($row);

                $signatures_item = array(
                    "id" => $id,
                    "user_id" => $user_id,
                    "signed_at" => $signed_at,
                    "petition_id" => $petition_id,
                    "comment" => $comment
                );

                array_push($signatures_arr["records"], $signatures_item);
              
            }

            http_response_code(200);
            echo json_encode($signatures_arr);
        } else {
            http_response_code(404);
            echo json_encode(array("message" => "No Signature found."));
        }
        break;

    case 'POST':
        $data = json_decode(file_get_contents("php://input"));

        if (
            !empty($data->user_id) &&
            !empty($data->signed_at) &&
            !empty($data->petition_id)
            &&!empty($data->comment)
            
        ) {
            $signatures->user_id = $data->user_id;
            $signatures->signed_at = $data->signed_at;
            $signatures->petition_id = $data->petition_id;
            $signatures->comment = $data->comment;

            if ($signatures->create()) {
                http_response_code(201);
                echo json_encode(array("message" => "Signature added in Database."));
            } else {
                http_response_code(503);
                echo json_encode(array("message" => "Unable to add Sign of petition."));
            }
        } else {
            http_response_code(400);
            echo json_encode(array("message" => "Unable to add Signature in database. Data is incomplete."));
        }
        break;

    case 'PUT':
        $data = json_decode(file_get_contents("php://input"));

        $signatures->id = $data->id;

        if (
            !empty($data->user_id) &&
            !empty($data->signed_at) &&
            !empty($data->petition_id)&&
            !empty($data->comment)
        ) {
            $signatures->user_id = $data->user_id;
            $signatures->signed_at = $data->signed_at;
            $signatures->petition_id = $data->petition_id;
            $signatures->comment = $data->comment;

            if ($signatures->update()) {
                http_response_code(200);
                echo json_encode(array("message" => "Signature has been Updated."));
            } else {
                http_response_code(503);
                echo json_encode(array("message" => "Unable to update Signature some error occured."));
            }
        } else {
            http_response_code(400);
            echo json_encode(array("message" => "Unable to update Signature. Data is incomplete."));
        }
        break;

    case 'DELETE':
        $data = json_decode(file_get_contents("php://input"));

        $signatures->id = $data->id;

        if ($signatures->delete()) {
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
