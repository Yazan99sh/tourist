<?php


namespace App\Service;


use App\AutoMapping;
use App\Entity\AcceptedOrderEntity;
use App\Entity\TouristOrderEntity;
use App\Manager\AcceptedOrderManager;
use App\Manager\TouristOrderManager;
use App\Repository\AcceptedOrderCreateResponse;
use App\Request\AcceptedOrderCreateRequest;
use App\Request\AcceptedOrderUpdateRequest;
use App\Request\TouristOrderCreateRequest;
use App\Request\TouristOrderUpdateRequest;
use App\Response\AcceptedOrderResponse;
use App\Response\AcceptedOrderUpdateResponse;
use App\Response\AllAcceptedOrdersGetResponse;
use App\Response\AllUnacceptedOrdersGetResponse;
use App\Response\OrderByGuidCityAndLanguageResponse;
use App\Response\TouristOrderCreateResponse;

class OrderService
{
    private $autoMapping;
    private $touristOrderManager;
    private $acceptedOrderManager;

    public function __construct(AutoMapping $autoMapping, TouristOrderManager $touristOrderManager, AcceptedOrderManager $acceptedOrderManager)
    {
        $this->autoMapping = $autoMapping;
        $this->touristOrderManager = $touristOrderManager;
        $this->acceptedOrderManager = $acceptedOrderManager;
    }

    public function createOrder(TouristOrderCreateRequest $request)
    {
        $orderCreate = $this->touristOrderManager->createOrder($request);

        $response = $this->autoMapping->map(TouristOrderEntity::class,TouristOrderCreateResponse::class, $orderCreate);

        return $response;
    }

    public function updateOrder(TouristOrderUpdateRequest $request)
    {
        $orderUpdate = $this->touristOrderManager->updateOrder($request);

        $response = $this->autoMapping->map(TouristOrderEntity::class,TouristOrderUpdateRequest::class, $orderUpdate);

        return $response;
    }

    // Get only accepted orders of a tourist
    public function getOrderByTourist($touristID)
    {
        $ordersResponse = [];
        $orders = $this->touristOrderManager->getOrderByTourist($touristID);
        foreach ($orders as $order)
        {
            $ordersResponse[] = $this->autoMapping->map('array', TouristOrderCreateResponse::class, $order);
        }

        return $ordersResponse;
    }

    // Get all orders of a tourist either they are accepted or not
    public function getAllOrdersByTouristID($touristID)
    {
        $ordersResponse = [];
        $orders = $this->touristOrderManager->getAllOrdersByTouristID($touristID);

        foreach ($orders as $order)
        {
            $ordersResponse[] = $this->autoMapping->map('array', TouristOrderCreateResponse::class, $order);
        }

        return $ordersResponse;
    }

    public function getOrderByGuidCityAndLanguage($guidUserID)
    {
        $ordersResponse = [];
        $orders = $this->touristOrderManager->getOrderByGuidCityAndLanguage($guidUserID);
        
        if(isset($orders))
        {
            foreach ($orders as $order)
            {
                $ordersResponse[] = $this->autoMapping->map('array', OrderByGuidCityAndLanguageResponse::class, $order);
            }
        }
        return $ordersResponse;
    }

    //Get orders with undefined guidUserID
    public function getOrdersByGuideCityAndLanguage($guideID)
    {
        $ordersResponse = [];
        $orders = $this->touristOrderManager->getOrdersByGuideCityAndLanguage($guideID);
        
        foreach ($orders as $order)
        {
            $ordersResponse[] = $this->autoMapping->map('array', OrderByGuidCityAndLanguageResponse::class, $order);
        }

        return $ordersResponse;
    }

    public function acceptOrderCreate(AcceptedOrderCreateRequest $request)
    {
        $request->setUuid($this->uuid());
        $create = $this->acceptedOrderManager->acceptOrderCreate($request);

        $response = $this->autoMapping->map(AcceptedOrderEntity::class,AcceptedOrderCreateResponse::class, $create);

        return $response;
    }

    // Get all pending accepted orders of tourist
    public function getAcceptedOrder($userID)
    {
        $ordersResponse = [];
        $orders = $this->acceptedOrderManager->getAcceptedOrder($userID);
        foreach ($orders as $order)
        {
            $ordersResponse[] = $this->autoMapping->map('array', AcceptedOrderResponse::class, $order);
        }

        return $ordersResponse;
    }

    // Get all accepted orders of tourist whatever status is
    public function getAllAcceptedOrdersOfTourist($touristID)
    {
        $ordersResponse = [];
        $orders = $this->acceptedOrderManager->getAllAcceptedOrdersOfTourist($touristID);

        foreach ($orders as $order)
        {
            if($order)
            {
                $placeId = $order['order']['city'];

                $region = $this->acceptedOrderManager->getRegionNameByPlaceId($placeId);

                if($region)
                {
                    $order['order']['city'] = $region['name'];
                }
            }
            
            $ordersResponse[] = $this->autoMapping->map('array', AcceptedOrderResponse::class, $order);
        }

        return $ordersResponse;
    }

    public function getAcceptcdOrdersByGuide($guideID)
    {
        $ordersResponse = [];
        $orders = $this->acceptedOrderManager->getAcceptcdOrdersByGuide($guideID);

        foreach ($orders as $order)
        {
            if($order)
            {
                //dd($order['order']->getCity());
                $placeId = $order['order']->getCity();

                $region = $this->acceptedOrderManager->getRegionNameByPlaceId($placeId);

                if($region)
                {
                    $order['order']->setCity($region['name']);
                }
            }

            $ordersResponse[] = $this->autoMapping->map('array', AcceptedOrderResponse::class, $order);
        }

        return $ordersResponse;
    }

    public function acceptedOrderUpdate(AcceptedOrderUpdateRequest $request)
    {
        $orderUpdate = $this->acceptedOrderManager->acceptedOrderUpdate($request);

        $response = $this->autoMapping->map(AcceptedOrderEntity::class,AcceptedOrderUpdateResponse::class, $orderUpdate);

        return $response;
    }

    public function getOrderByGuid($guidUserID)
    {
        $ordersResponse = [];
        $orders = $this->touristOrderManager->getOrderByGuid($guidUserID);
       
        foreach ($orders as $order)
        {
            $ordersResponse[] = $this->autoMapping->map('array', TouristOrderCreateResponse::class, $order);
        }

        return $ordersResponse;
    }

    public function getOrdersByGuideIDForDashboard($guidUserID)
    {
        $ordersResponse = [];
        $orders = $this->touristOrderManager->getOrdersByGuideIdForDashboard($guidUserID);
       
        foreach ($orders as $order)
        {
            $ordersResponse[] = $this->autoMapping->map('array', TouristOrderCreateResponse::class, $order);
        }

        return $ordersResponse;
    }
    
    // for generate uuid
    public function uuid()
    {
        $data = random_bytes(16);

        $data[0] = chr(ord('c') ); 
        $data[1] = chr(ord('4') ); 
        $data[2] = chr(ord('d') ); 
        $data[6] = chr(ord($data[6]) & 0x0f | 0x40);
        $data[8] = chr(ord($data[8]) & 0x3f | 0x80);
        return  vsprintf('%s%s-%s-%s-%s-%s%s%s', str_split(bin2hex($data), 4));
    }

    public function getAcceptedOrdersByStatus($status)
    {
        $ordersResponse = [];
        $orders = $this->acceptedOrderManager->getAcceptedOrdersByStatus($status);

        foreach ($orders as $order)
        {
            $ordersResponse[] = $this->autoMapping->map('array', AllAcceptedOrdersGetResponse::class, $order);
        }

        return $ordersResponse;
    }
    
    // Get all orders which hasn't been accepted by any guide
    public function getUnacceptedOrders()
    {
        $ordersResponse = [];
        $acceptedOrdersIDs = $this->acceptedOrderManager->getOrdersIDs();
        $unacceptedOrders = $this->touristOrderManager->getUnacceptedOrders();

        foreach ($unacceptedOrders as $order)
        {
            // We first have to check if the order is being accepted or not
            // That's done via check if the order id is in the accepted orders IDs
            if(!$this->searchMyArray($acceptedOrdersIDs, $order['id']))
            {
                $ordersResponse[] = $this->autoMapping->map('array', AllUnacceptedOrdersGetResponse::class, $order);
            }
        }

        return $ordersResponse;
    }

    public function searchMyArray($target_array, $search)
    {   
        foreach ($target_array as $array_item) 
        {
            foreach($array_item as $item)
            {
                if ($item == $search) 
                {
                    return true;
                }
            }
        }
    }
}