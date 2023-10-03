package py.com.flextech.services;

import java.io.IOException;

import com.fasterxml.jackson.core.JsonProcessingException;

import py.com.flextech.models.dto.ChatResponseDto;
import py.com.flextech.models.dto.MessageDto;
import py.com.flextech.models.dto.file.SendFileResponse;
import py.com.flextech.models.dto.text.WhatsAppSendFileDto;
import py.com.flextech.models.uazapi.session.UazapiCreateInstance;
import py.com.flextech.models.uazapi.session.UazapiCreateInstanceResponse;
import py.com.flextech.models.uazapi.session.UazapiLogoutResponse;

interface IEventService {

    public UazapiCreateInstanceResponse startSession(UazapiCreateInstance instance)
            throws JsonProcessingException, IOException, InterruptedException;

    public ChatResponseDto sendMessage(String sessionKey, String token, MessageDto message)
            throws JsonProcessingException, IOException, InterruptedException;

    public SendFileResponse sendFile64(String sessionKey, String token, WhatsAppSendFileDto dto)
            throws JsonProcessingException, IOException, InterruptedException;

    public UazapiLogoutResponse logoutSession(String sessionKey) throws IOException, InterruptedException;

}