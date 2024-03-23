//
//  Registration.swift
//  Octus
//
//  Created by Руслан on 08.12.2023.
//

import Foundation
import Firebase
import FirebaseAuth
import GoogleSignIn
import AuthenticationServices
import FirebaseFirestore


class Registration: NSObject {

     
    func google(controller:UIViewController,completion: @escaping (AuthCredential?,String?) -> ()) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        GIDSignIn.sharedInstance.signIn(withPresenting: controller) { result, error in
            guard error == nil else {
                completion(nil,nil)
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
                completion(nil,nil)
                return
            }
            
            let name = user.profile?.name
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            
            completion(credential,name)
        }
    }
    
    func apple() -> ASAuthorizationController {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName,.email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.performRequests()
        return controller
    }
    
    func createEmailAndPassword(email:String,password:String,completion: @escaping (AuthCredential?,Error?) -> ()) {
        let emailLast = email.trimmingCharacters(in: .whitespaces)
        let passwordLast = password.trimmingCharacters(in: .whitespaces)
        
        Auth.auth().createUser(withEmail: emailLast, password: passwordLast) { authResult, error in
            if error != nil {
                completion(nil,error)
                //print(ErrorRegistr(rawValue: ))
            }else {
                completion(authResult?.credential,nil)
            }
        }
    }
    
    func signInEmailAndPassword(email:String,password:String,completion: @escaping (AuthCredential?,Error?) -> ()) {
        
        let emailLast = email.trimmingCharacters(in: .whitespaces)
        let passwordLast = password.trimmingCharacters(in: .whitespaces)
        
        Auth.auth().signIn(withEmail: emailLast, password: passwordLast) { result, err in
            if err != nil {
                completion(nil,err)
            }else {
                completion(result?.credential,nil)
            }
        }
    }
    
}
extension RegistrViewController: ASAuthorizationControllerDelegate,ASAuthorizationControllerPresentationContextProviding {
    
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        self.error.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.error.isHidden = true
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential else { return }

        let firstName = appleIDCredential.fullName?.givenName
        
        if firstName != nil {
            UD().saveNameUser(name: firstName!)
            performSegue(withIdentifier: "succes", sender: self)
        }else {
            alertName()
        }
        
        
    }
    
    
    func alertName() {
        let alert = UIAlertController(title: "Впишите имя", message: nil, preferredStyle: .alert)

        alert.addTextField{ tf in
            tf.placeholder = "Имя"
        }

        alert.addAction(UIAlertAction(title: "Сохранить", style: .default) { _ in
            let textField = alert.textFields![0]
            guard textField.text != "" else {
                self.error.isHidden = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.error.isHidden = true
                }
                return
            }
            UD().saveNameUser(name: textField.text!)
            self.performSegue(withIdentifier: "succes", sender: self)
        })
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))

        present(alert, animated: true, completion: nil)
    }
}
